Rails.application.routes.draw do

  # ------------------------------------------ Devise

  mount Heartwood::Engine, :at => :users

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

  # ------------------------------------------ App

  resources :sites, :except => [:destroy], :param => :slug do
  #   scope :module => 'sites' do
  #     resources :page_types, :param => :slug, :path => :t do
  #       scope :module => :page_types do
  #         resources :pages, :param => :slug, :path => :p
  #       end
  #     end
  #     resources :users
  #   end
  end

  # ------------------------------------------ Home Page

  root :to => 'application#home'

end
