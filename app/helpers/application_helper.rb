module ApplicationHelper

  def data
    @data ||= {
      :title => current_site ? current_site.title : "rocktree"
    }
  end

end
