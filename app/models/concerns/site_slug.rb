module SiteSlug
  extend ActiveSupport::Concern

  included do
    after_save :sluggify_slug
  end

  def sluggify_slug
    s = slug.blank? ? create_slug : clean_slug(slug)
    update_column(:slug, s) unless slug == s
    s
  end

  def create_slug
    slug = clean_slug(self.title.downcase.gsub(/\&/, ' and '))
    dups = self.site.send(self.class.table_name).where(:slug => slug) - [self]
    slug = "#{slug}-#{self.id}" if dups.count > 0
    slug
  end

  def clean_slug(s)
    clean_slug = s.gsub(/[^a-zA-Z0-9 \-]/, "") # remove all bad characters
    clean_slug.gsub!(/\ /, "-") # replace spaces with underscores
    clean_slug.gsub!(/\-+/, "-") # replace repeating underscores
    clean_slug
  end

  def to_param
    slug
  end

end
