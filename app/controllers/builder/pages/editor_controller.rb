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
      # body_md = params[:page][:body_md]
      # body    = parse_markdown(body_md)
      # current_page.update(
      #   :body_md => body_md,
      #   :body => body
      # )
      render :json => { :html => parse_markdown(params[:page][:body_md]) }
      # @post = Post.find_by_slug(params[:post_slug])
      # @post.update_columns(:markdown => params[:post][:markdown])
      # render :json => { :html => parse_markdown(@post.markdown) }
    else
      fail "Couldn't find editor"
    end
  end

end
