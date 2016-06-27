class ExportSite

  def initialize(options = {})
    @site = options[:site]
  end

  def self.call(options = {})
    new(options).call
  end

  def call
    begin
      # Delete the enclosing directory if it exists. (Really, this should already
      # be gone because it's cleaned at the end of this process.)
      FileUtils.rm_rf(dir) if Dir.exists?(dir)
      # Delete the zip file if it exists.
      FileUtils.rm(zip_file) if File.exists?(zip_file)
      # Make us a new directory.
      FileUtils.mkdir_p(dir)
      # Set the site to show we're processing the export.
      @site.export_processing!
      # Export the pages to an overall spreadsheet.
      export_pages
      # Export the resources, using the site's pages.
      export_resources
      # Export page data, but break it up into individual templates so we can see
      # their custom field data.
      export_pages_by_template
      # Export the media files into their own directory.
      export_media
      # Create a zip file using the contents we've just packaged up.
      ZipFileGenerator.call(dir, zip_file)
      # Remove the files we created and downloaded since we now have the zipped
      # reference.
      FileUtils.rm_rf(dir) if Dir.exists?(dir)
      # Set the site as having its export ready.
      @site.export_ready!
      # Return the zip file.
      zip_file
    rescue
      @site.export_missing!
    end
  end

  private

    def dir
      @dir ||= Rails.root.join('lib', 'exports', @site.slug).to_s
    end

    def zip_file
      @zip_file ||= Rails.root.join('lib', 'exports', "#{@site.slug}.zip").to_s
    end

    def templates
      @templates ||= begin
        @site.templates.includes(:template_fields, :webpages => [
          :template, :resources => [:resource_type]])
      end
    end

    def export_pages
      CSV.open("#{dir}/pages.csv", 'w+') do |csv|
        csv << %w(Title Path Template)
        @site.webpages.each do |page|
          csv << [page.title, page.page_path, page.template.title]
        end
      end
    end

    def export_pages_by_template
      templates.each do |template|
        fields = { 'page_path' => 'Page Path' }
        template.fields.each { |field| fields[field.slug] = field.title }
        fields = fields.sort.to_h
        FileUtils.mkdir_p("#{dir}/templates")
        CSV.open("#{dir}/templates/#{template.slug}.csv", 'w+') do |csv|
          csv << fields.values
          template.webpages.each do |page|
            attrs = []
            fields.each { |field, label| attrs << page.send(field) }
            csv << attrs
          end
        end
      end
    end

    def export_resources
      FileUtils.mkdir_p("#{dir}/resources")
      @site.resource_types.includes(:resource_fields).each do |resource_type|
        CSV.open("#{dir}/resources/#{resource_type.slug}.csv", 'w+') do |csv|
          fields = {}
          resource_type.resource_fields.each do |field|
            fields[field.slug] = field.title
          end
          csv << ['Page Path'] + fields.values
          @site.webpages.each do |page|
            page.resources.where(:resource_type_id => resource_type.id).each do |resource|
              attrs = [page.page_path]
              fields.each do |field, label|
                attrs << resource.send(field)
              end
              csv << attrs
            end
          end
        end
      end
    end

    def export_media
      FileUtils.mkdir_p(docs_dir = "#{dir}/media")
      @site.documents.each do |doc|
        open("#{docs_dir}/#{doc.document.name}", 'wb') do |file|
          begin
            file << open(doc.document.url).read
          rescue
            nil
          end
        end
      end
    end

end
