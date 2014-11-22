module UsersHelper

  def admin?
    current_user.admin?
  end

  def avatar(user, size = 100, klass = nil)
    default_url = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    content_tag(:div, :class => "avatar-container #{klass}") do
      image_tag "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm", 
        :class => 'avatar'
    end
  end

  def site_admin?(user = current_user)
    su = user.site_users.select { |u| u.site_id = current_site.id }.first
    return su.site_admin? unless su.nil?
    false
  end

end
