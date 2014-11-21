class Sites::PagesController < SitesController

  def show
    current_page
    unless page_type_children.size > 0
      redirect_to site_route([current_page], :edit)
    end
  end

  def new
    redirect_to current_site unless params[:page_type]
    @current_page_type = current_site.page_types.find_by_slug(params[:page_type])
    @current_page = Page.new
  end

  def create
    process_images
    @current_page = Page.new(create_params)
    if current_page.save!
      save_images
      redirect_to(
        site_route([current_page], :show), 
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
    process_images
    if current_page.update(update_params)
      save_images
      redirect_to(site_route([current_page], :show),
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
    redirect_to(site_route([parent_page], :show), 
      :notice => t('notices.updated', :item => 'Page'))
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

    def process_images
      @images_to_save = {}
      unless params[:page][:field_data].nil?
        keys = params[:page][:field_data].keys
        keys.each do |key|
          if key.starts_with?('rtimage_')
            clean_key = key.gsub(/rtimage\_/, '')
            value = params[:page][:field_data][key.to_sym]
            params[:page][:field_data][clean_key.to_sym] = value
            @images_to_save[clean_key] = value.to_i
          end
        end
      end
    end

    def save_images
      images = current_site.images.where(:idx => @images_to_save.values)
      @images_to_save.each do |field_name, idx|
        image = images.select { |i| i.idx == idx }.first
        PageImage.find_or_create_by(
          :page => current_page,
          :image => image,
          :field_name => field_name
        )
      end
    end

end
