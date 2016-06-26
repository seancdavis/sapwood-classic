class ExportSite

  def initialize(options = {})
    @site = options[:site]
    @templates = @site.templates.includes(:template_fields, :webpages => [:template])
  end

  def call
    @key = SecureRandom.hex(24)
    dir = Rails.root.join('tmp', 'exports', @key, @site.slug).to_s
    zip_file = Rails.root.join('tmp', 'exports', @key, "#{@site.slug}.zip").to_s
    FileUtils.mkdir_p(dir)
    CSV.open("#{dir}/#{@site.slug}.csv", 'w+') do |csv|
      csv << %w(Title Path Template)
      @site.webpages.each do |page|
        csv << [page.title, page.page_path, page.template.title]
      end
    end
    @templates.each do |template|
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
    FileUtils.mkdir_p(docs_dir = "#{dir}/media")
    @site.documents.each do |doc|
      open("#{docs_dir}/#{doc.document.name}", 'wb') do |file|
        file << open(doc.document.url).read
      end
    end
    ZipFileGenerator.call(dir, zip_file)
    true
  end

  def self.call(options = {})
    new(options).call
  end

end
