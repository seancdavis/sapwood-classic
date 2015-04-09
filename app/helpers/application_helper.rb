module ApplicationHelper

  def data
    @data ||= {
      :title => current_site ? current_site.title : SapwoodSetting.site.title
    }
  end

  def settings
    @settings ||= Setting.alpha
  end

  def setting(name)
    settings.select { |s| s.title == name }.first
  end

end
