module UsersHelper

  def avatar(user, size = 100, klass = nil)
    default_url = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    content_tag(:div, :class => "avatar-container #{klass}") do
      image_tag "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm", 
        :class => 'avatar'
    end
  end

end
