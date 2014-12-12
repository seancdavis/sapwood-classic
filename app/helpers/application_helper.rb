module ApplicationHelper

  def data
    @data ||= {
      :title => current_site ? current_site.title : TaprootSetting.site.title
    }
  end

end
