Goodbrews::Application.routes.draw do
  root :to => 'dashboard#index', :constraints => lambda { |request| request.cookies['auth_token'] }
  root :to => 'pages#welcome'

  constraint = lambda { |request| request.cookies['auth_token'] && User.find_by_auth_token(request.cookies['auth_token']).username == 'davidcelis' }
  constraints constraint do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  resource :account, :controller => :account, :except => :show do
    collection do
      get  :sign_in, :controller  => :authentication, :action => :sign_in, :as => :sign_in
      post :sign_in, :controller  => :authentication, :action => :authenticate, :as => :authenticate
      post :sign_out, :controller => :authentication, :action => :sign_out, :as => :sign_out

      get  :ignored
    end
  end

  resources :password_resets, :only => [:new, :create, :edit, :update]

  resource :dashboard, :controller => :dashboard, :only => :index do
    collection do
      get '' => :index, :as => '' # Cool story, Rails
      get :recommendations
      get :likes
      get :dislikes
      get :fridge
      get :similar
    end
  end

  resources :beers, :only => [] do
    member do
      post   :like
      delete :like,    :action => :unlike,    :as => :unlike
      post   :dislike
      delete :dislike, :action => :undislike, :as => :undislike
      post   :ignore
      delete :ignore,  :action => :unignore,  :as => :unignore
      post   :stash
      delete :stash,   :action => :unstash,   :as => :unstash
    end
  end

  resources :breweries, :only => :show do
    get :discontinued, :on => :member
  end

  %w[beer brewery].each do |model|
    get  "#{model.pluralize}/suggested"   => "temp_#{model.pluralize}#index",   :as => "suggested_#{model.pluralize}"
    get  "#{model.pluralize}/suggest"     => "temp_#{model.pluralize}#new",     :as => "new_suggested_#{model}"
    post "#{model.pluralize}"             => "temp_#{model.pluralize}#create",  :as => "create_suggested_#{model}"
    post "#{model.pluralize}/:id/approve" => "temp_#{model.pluralize}#approve", :as => "approve_suggested_#{model}"
  end

  resources :users, :only => :show do
    member do
      get :recommendations
      get :likes
      get :dislikes
      get :fridge
      get :similar
    end
  end

  controller :searches do
    get '/search/beers', :as => :beers_search
    get '/search/breweries', :as => :breweries_search
    get '/search/users', :as => :users_search
  end

  controller :pages do
    get :welcome
    get :about
    get :privacy
    get :terms
  end
end
