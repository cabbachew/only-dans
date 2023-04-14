Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}

  # Define routes to create, update, and destroy friendships
  post "/friendships", to: "friendships#create", as: "create_friendship"
  put "/friendships", to: "friendships#update", as: "update_friendship"
  delete "/friendships", to: "friendships#destroy", as: "destroy_friendship"

  # Define routes for posts
  resources :posts

  # Define route for user profile
  get "/profile/:id", to: "pages#profile", as: "profile"

  # Define the root route
  root "pages#index"
end
