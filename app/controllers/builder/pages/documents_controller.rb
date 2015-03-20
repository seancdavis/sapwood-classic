class Builder::Pages::DocumentsController < Builder::PagesController

  def index
  end

  def create
    if request.xhr? && params[:file]
      doc = current_site.documents.find_by_idx(params[:file])
      unless doc.nil?
        PageDocument.create!(
          :page => current_page,
          :document => doc
        )
        render :nothing => true
      end
    end
  end

  def destroy
    doc = current_site.documents.find_by_idx(params[:idx])
    unless doc.nil?
      association = PageDocument.where(
        :page => current_page, :document => doc
      ).first
      association.destroy unless association.nil?
    end
    redirect_to(
      builder_site_page_documents_path(current_site, current_page)
    )
  end

end
