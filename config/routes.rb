Rails.application.routes.draw do

  ######################################################################
  # BEGIN Cambium
  ######################################################################
  # 
  # The following are Cambium's default routes. Feel free to customize (or
  # delete) these to fit your needs.
  # 
  ######################################################################
  # WARNING: MAKE SURE YOU REMOVE ANY DUPLICATES AND REARRANGE TO AVOID
  # CONFLICTS WITH YOUR EXISTING ROUTES.
  ######################################################################
  # 
  # ------------------------------------------ Devise
  # 
  # Only use this section if you've installed Cambium's user authentication
  # system (which uses Devise). 
  # 
  # The following line is necessary to add Devise's routes. The :skip argument
  # is ommitting registration routes, since we don't use the registration module
  # by default. And we only skip sessions because we rewrite those routes below
  # so they are a little cleaner.
  # 
  # devise_for :users, :skip => [:sessions, :registrations]
  # devise_scope :user do
  #   get '/login' => 'devise/sessions#new', :as => :new_user_session
  #   post '/login' => 'devise/sessions#create', :as => :user_session
  #   get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  # 
  # ------------------------------------------ Admin
  # 
  # Only use this section if you plan to implement Cambium's admin module. Do
  # note, if you accidentally delete it before you run the admin generator, they
  # will be regenerated.
  # 
  # This routes to our admin dashboard, which we don't use by default. It really
  # just redirects to the controller of your choosing.
  # 
  # get '/admin' => 'admin#dashboard', :as => :admin_dashboard
  # 
  # All additional admin routes should be nested under the :admin namespace.
  # Here we show an example that includes the users routes.
  # 
  # namespace :admin do
  #   resources :users, :except => [:show]
  # end
  # 
  # ------------------------------------------ JSON
  # 
  # If you plan to use any public json routes, it's good to nest them in their
  # own scope. We use a scope instead of a namespace because a controller action
  # can have routes to it in different formats, so namespacing is unecessary.
  # 
  # scope 'json' do
  #   'users' => 'users#index'
  # end
  # 
  # ------------------------------------------ Public
  # 
  # After we define all namespaced routes, we can move on to those routes that
  # are not namespaced.
  # 
  # resources :users
  # 
  # ------------------------------------------ Home Page
  # 
  # We end the routes file with the root route, which defines our application's
  # home page. This is essential and should only be defined once -- after all
  # other routes.
  # 
  # root :to => 'home#index'
  # 
  ######################################################################
  # END Cambium
  ######################################################################

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
