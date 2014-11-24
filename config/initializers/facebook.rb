$facebook = Koala::Facebook::OAuth.new(
  PRIVATE['facebook']['app_id'], 
  PRIVATE['facebook']['secret'],
  PRIVATE['facebook']['redirect_url']
)
