class BuilderNav

  def initialize(site)
    @site = site
  end

  def site_nav
    file = "#{Rails.root}/config/taproot/builder_site_nav.yml"
    return nil unless File.exists?(file)
    nav = {}
    YAML.load_file(file).each { |k,v| nav[k] = v.to_ostruct }
    nav
  end

end
