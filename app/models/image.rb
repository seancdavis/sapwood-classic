# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  image_uid  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  idx        :integer          default(0)
#  crop_data  :text
#  image_site :string(255)
#  image_name :string(255)
#

class Image < ActiveRecord::Base

  # ------------------------------------------ Plugins

  dragonfly_accessor :image

  # ------------------------------------------ Attributes

  serialize :crop_data, Hash

  # ------------------------------------------ Associations

  belongs_to :site, :touch => true

  has_many :page_images
  has_many :pages, :through => :page_images

  # ------------------------------------------ Scopes

  scope :by_idx, -> { reorder('idx asc') }

  # ------------------------------------------ Callbacks

  after_create :create_idx

  after_save :cache_attrs

  def cache_attrs
    update_columns(
      :image_site => site.slug, 
      :image_name => self.image.meta['name']
    )
  end

  # ------------------------------------------ Validations

  validates_property(
    :format, 
    :of => :image, 
    :in => ['jpeg', 'jpg', 'png', 'gif']
  )

  # ------------------------------------------ Instance Methods

  def to_param
    idx.to_s
  end

  def create_idx
    last_obj = self.site.images.by_idx.last
    idx = last_obj.idx + 1
    update_columns(:idx => idx)
  end

  def method_missing(method, *arguments, &block)
    begin
      super
    rescue
      crop_data.keys.include?(method.to_s) ? crop(method.to_s) : super
    end
  end

  def respond_to?(method, include_private = false)
    begin
      super
    rescue
      crop_data.keys.include?(method.to_s) ? true : false
    end
  end

  def crop(version)
    unless crop_data[version].blank?
      hash = crop_data[version].map { |k,v| {k => v.to_f} }.reduce(:merge)
      OpenStruct.new(hash)
    end
  end

  def url_things
    ['hello_world','beast'].join('/')
  end

end
