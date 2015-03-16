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

end
