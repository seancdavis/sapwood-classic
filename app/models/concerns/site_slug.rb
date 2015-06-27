module SiteSlug
  extend ActiveSupport::Concern

  included do
    after_save :sluggify_slug
  end

  def sluggify_slug
    unless title.blank?
      s = slug.blank? ? create_slug : clean_slug(slug)
      update_column(:slug, s) unless slug == s
      s
    end
  end

  def create_slug
    association = self.class.table_name.gsub(/^heartwood\_/, '')
    slug = clean_slug(self.title.downcase)
    if self.class == Page
      dups = self.site.webpages.where(:slug => slug) - [self]
    else
      dups = self.site.send(association).where(:slug => slug) - [self]
    end
    underscore_classes = [Template, ResourceType, SiteSetting]
    separator = underscore_classes.include?(self.class) ? '_' : '-'
    slug = "#{slug}#{separator}#{self.id}" if dups.count > 0
    slug
  end

  def clean_slug(s)
    clean_slug = s.gsub(/\&/, ' and ') # replace ampersand with "and"
    clean_slug = clean_slug.gsub(/\./, '-') # replace periods with hyphens
    clean_slug = clean_slug.gsub(/[^a-zA-Z0-9 \-\_]/, "") # remove any remaining bad characters
    underscore_classes = [Template, ResourceType, SiteSetting]
    separator = underscore_classes.include?(self.class) ? '_' : '-'
    clean_slug.gsub!(/\ /, separator) # replace spaces with underscores
    clean_slug.gsub!(/#{separator}+/, separator) # replace repeating underscores
    clean_slug
  end

  def to_param
    slug
  end

end
