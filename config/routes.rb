Rails.application.routes.draw do

  # ------------------------------------------ Domains

  Site.all.each do |site|
    unless site.url.nil?
      constraints DomainConstraint.new(site.url) do
        get(
          '/' => 'viewer/pages#home', 
          :as => :"#{site.slug}_home"
        )
        get(
          '/*page_path' => 'viewer/pages#show', 
          :as => :"#{site.slug}_page"
        )
      end
    end
  end

  # ------------------------------------------ App Admin

  namespace :admin do
    get 'facebook/auth' => 'facebook#auth', :as => :facebook_auth
  end

  # ------------------------------------------ Devise

  devise_for :users, :skip => [:sessions, :registrations]
  devise_scope :user do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  # ------------------------------------------ Builder

  namespace :builder, :path => '' do
    resources :sites, :except => [:destroy], :param => :slug do
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

  # ------------------------------------------ API

  namespace :api do
    namespace :v1 do
      resources :forms, :only => [:create]
    end
  end

  # ------------------------------------------ Viewer

  namespace :viewer, :path => '' do
    scope ':site_slug' do
      get '/' => 'pages#home', :as => :home
      get '/*page_path' => 'pages#show', :as => :page
    end
  end

  # ------------------------------------------ Home Page

  root :to => 'builder#home'

end
