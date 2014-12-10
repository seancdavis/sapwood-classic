# rtsym:app/viewer_services/default_site.rb
# 
# Site Service Object
# =================
# 
# This file is for site-specific logic that you need for the front-end of your
# website.
# 
# There is a helper that loads an instance of this class into a `viewer_service`
# variable. For exmaple, let's say you have a method like this:
# 
#     def contact_form
#       @site.forms.find_by_slug('contact')
#     end
# 
# You would could load the form with:
# 
#     viewer_service.contact_form
# 
# It is recommended that if you are going to use a querying method more than
# once in a template that you load it into a variable. For exmaple, you could
# put this in your view template:
# 
#     <% form = viewer_service.contact_form %>
# 
# Then you would have the form stored in the `form` variable, and you would only
# hit the database once for that form.
# 
class DefaultSiteViewer

  # We load the site into the class so we can have it in all our methods. If you
  # need access to any other data throughout this service object, load it here.
  # 
  # If you add more parameters to this method, they should have default values,
  # so as to not conflict with our `viewer_service` method.
  # 
  def initialize(site)
    @site = site
  end

end
