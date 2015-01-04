class Builder::Pages::EditorController < Builder::PagesController

  include MarkdownHelper

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
    else
      fail "Couldn't find editor"
    end
  end

end
