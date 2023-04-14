Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}

  # Define routes to create and destroy friendships
  post "/friendships", to: "friendships#create", as: "friendships"
  delete "/friendships", to: "friendships#destroy", as: "friendship"

  # Define routes for posts
  resources :posts

  # Define route for user profile
  get "/profile/:id", to: "pages#profile", as: "profile"

  # Define the root route
  root "pages#index"
end
