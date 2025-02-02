Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"
  get "users/login", to: "users#new", as: "login"
  post "users/login", to: "users#login"
  get "users/logout", to: "users#logout", as: "logout"
  get "posts/my-posts", to: "posts#user_posts", as: "my_posts"
  resources :users, only: [ :show, :new, :create ]
  resources :posts
end
