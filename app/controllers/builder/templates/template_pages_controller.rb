class Builder::Templates::TemplatePagesController < BuilderController

  def index
    @pages = current_template_pages
    if params[:published] 
      if ['published','draft'].include?(params[:published])
        @pages = @pages.select { |p| p.send("#{params[:published]}?") }
      end
    else
      redirect_to builder_site_template_pages_path(
        current_site, 
        current_template, 
        :published => 'all'
      )
    end
    @paginated_pages = Kaminari.paginate_array(@pages).page(params[:page]).per(10)
  end

end
