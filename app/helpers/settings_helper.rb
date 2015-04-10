module SettingsHelper

  def site_settings
    @site_settings ||= current_site.settings.alpha
  end

  def site_setting(name)
    setting = site_settings.select { |s| s.slug == name }.first
    setting.nil? ? nil : setting.value.html_safe
  end

  def current_setting
    @current_setting ||= begin
      p = params[:slug] || params[:setting_slug]
      site_settings.select { |s| s.slug == p }.first
    end
  end

  def site_settings_breadcrumbs
    o = link_to(
      "site settings",
      builder_site_site_settings_path(current_site)
    )
    if current_setting
      o += content_tag(:span, '/', :class => 'separator')
      if current_setting.id.blank?
        o += link_to(
          "new setting",
          new_builder_site_site_setting_path(current_site),
          :class => 'disabled'
        )
      else
        o += link_to(
          current_setting.slug,
          builder_route([current_setting], :edit),
          :class => 'disabled'
        )
      end
    end
    o.html_safe
  end

end
