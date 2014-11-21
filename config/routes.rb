Rails.application.routes.draw do

  # ------------------------------------------ Devise

  devise_for :users, :skip => [:sessions, :registrations]
  devise_scope :user do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

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
    scope :module => 'sites' do
      resources :page_types, :param => :slug, :except => [:show]
      resources :pages, :param => :slug
      resources :forms, :param => :slug, :except => [:show]
      resources :images, :param => :idx, :except => [:show] do
        get 'crop' => 'images/croppings#edit', :as => :cropper 
        patch 'crop' => 'images/croppings#update', :as => :crop
      end
      resources :users, :except => [:show]
    end
  end

  # ------------------------------------------ Home Page

  root :to => 'application#home'

end
