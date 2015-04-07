class Builder::Pages::EditorController < Builder::PagesController

  before_filter :verify_admin, :only => []

  include EditorHelper

  def edit
    if request.xhr?
      render(params[:editor], :layout => false)
    else
      fail "Will only accept xhr requests."
    end
  end

  def parse
    case params[:editor]
    when 'markdown'
      render :json => { :html => parse_markdown(params[:page][:body_md]) }
    when 'wysiwyg'
      render :json => { :markdown => html_to_markdown(params[:page][:body]) }
    else
      fail "Couldn't find editor"
    end
  end

end
