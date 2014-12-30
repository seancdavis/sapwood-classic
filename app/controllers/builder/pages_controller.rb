class Builder::PagesController < BuilderController

  def index
    if site_root_pages.size > 0
      redirect_to(builder_route([site_root_pages.first], :show))
    else
      redirect_to(builder_route([site_root_pages], :new))
    end
  end

  def show
    current_page
    unless page_type_children.size > 0
      redirect_to builder_route([current_page], :edit)
    end
  end

  def new
    redirect_to current_site unless params[:page_type]
    @current_page_type = current_site.page_types.find_by_slug(params[:page_type])
    @current_page = Page.new
  end

  def create
    process_files
    @current_page = Page.new(create_params)
    if current_page.save!
      # save_files
      redirect_to(
        builder_route([current_page], :show), 
        :notice => t(
          'notices.created', 
          :item => controller_name.humanize.titleize
        )
      )
    else
      render('new')
    end
  end

  def update
    process_files
    if current_page.update(update_params)
      # save_files
      redirect_to(builder_route([current_page], :show),
        :notice => t(
          'notices.updated', 
          :item => controller_name.humanize.titleize
        )
      )
    else
      render('edit')
    end
  end

  def destroy
    parent_page = current_page.parent
    current_page.destroy
    if parent_page.nil?
      path = builder_route([site_root_pages], :index)
    else
      path = builder_route([parent_page], :show)
    end
    redirect_to(
      path, 
      :notice => t('notices.updated', :item => 'Page')
    )
  end

  private

    def create_params
      @current_page_type = current_site.page_types.find_by_id(
        params[:page][:page_type_id]
      )
      fields = []
      current_page_type.groups.each { |g| fields << g.fields }
      fields = fields.flatten.uniq.collect(&:slug).map { |f| f.to_sym }
      params.require(:page).permit(
        :title,
        :slug,  
        :description, 
        :body, 
        :published,
        :position,
        :template,
        :parent_id,
        :field_data => fields
      ).merge(
        :page_type => current_page_type,
      )
    end

    def update_params
      fields = []
      current_page_type.groups.each { |g| fields << g.fields }
      fields = fields.flatten.uniq.collect(&:slug).map { |f| f.to_sym }
      params.require(:page).permit(
        :title,
        :slug,  
        :description, 
        :body, 
        :published,
        :position,
        :parent_id,
        :template,
        :field_data => fields
      )
    end

    def process_files
      @files_to_save = {}
      unless params[:page][:field_data].nil?
        keys = params[:page][:field_data].keys
        keys.each do |key|
          value = nil
          if key.starts_with?('rtfile_')
            clean_key = key.gsub(/rtfile\_/, '')
            value = params[:page][:field_data][key.to_sym]
            params[:page][:field_data][clean_key.to_sym] = value
            @files_to_save[clean_key] = value.to_i
          end
        end
      end
    end

    # def save_files
    #   files = current_site.documents.where(:idx => @files_to_save.values)
    #   @files_to_save.each do |field_name, idx|
    #     image = files.select { |i| i.idx == idx }.first
    #     PageImage.find_or_create_by(
    #       :page => current_page,
    #       :image => image,
    #       :field_name => field_name
    #     )
    #   end
    # end

end
