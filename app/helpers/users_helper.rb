module UsersHelper

  def avatar(user, size = 100)
    default_url = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    image_tag "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm", 
      :class => 'avatar'
  end

end
