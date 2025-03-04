Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # admin routes
  namespace :admin do
    get "/posts", to: "posts#index"
    post "/posts", to: "posts#create"
    get "/posts/:id", to: "posts#show"
    delete "/posts/:id", to: "posts#destroy"
    get "/posts/:id/edit", to: "posts#edit"
    patch "/posts/:id/edit", to: "posts#update", as: "edit_post"

    get "/access_users", to: "access#index", as: "access"
    delete "/access_users/:id", to: "access#destroy"
    patch "/access_users/:id", to: "access#edit"
    get "/add_user", to: "access#new"
    post "/add_user", to: "access#create"
    get "/upload_user", to: "access#upload"

    get "/reports", to: "reports#index", as: "reports"
    get "/reports/export_users", to: "reports#export_users"
    get "/reports/export_active_users", to: "reports#export_active_users"
    get "/reports/export_posts", to: "reports#export_posts"
  end
  scope :admin do
    post "/posts/:id", to: "comments#create", as: "comments"
  end

  # posts routes
  get "/posts", to: "posts#index"
  post "/posts", to: "posts#create"
  get "/posts/:id", to: "posts#show"
  delete "/posts/:id", to: "posts#destroy"
  get "posts/:id/edit", to: "posts#edit"
  patch "/posts/:id/edit", to: "posts#update", as: "edit_post"

  # comments routes
  post "/posts/:id", to: "comments#create"

  # likes routes
  resources :likes, only: %i[create destroy]

  # Defines the root path route ("/")
  root "home#landing"
end
