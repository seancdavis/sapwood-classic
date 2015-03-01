Site.all.each do |site|
  unless site.url.blank?
    SitemapGenerator::Sitemap.default_host = "http://#{site.url}"
    SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/#{site.slug}"
    SitemapGenerator::Sitemap.create do
      site_pages = site.pages.includes(:template)
      (site_pages - [site.home_page]).each do |page|
        if page.page_path.present? && page.template.has_show_view?
          puts page.page_path
        end
      end
    end
  end
end
