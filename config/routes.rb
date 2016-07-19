Rails.application.routes.draw do
  get "/about" => "home#about"
  root "home#index"

  get "/posts" => "posts#posts"

  get "/home/new" => "posts#new", as: :new_post
  post "/posts" => "posts#create", as: :post
  get "/posts/search" => "posts#search", as: :search_post
  get "/posts/:id" => "posts#show", as: :blog

  get "/posts/:id/edit" => "posts#edit", as: :edit_post
  patch "/posts/:id" => "posts#update"

  delete "/posts/:id" => "posts#destroy"

  resources :users
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :passwordresets, only: [:new, :create, :edit, :update]
    # get "/passwordresets/:reset_token/edit" => "passwordresets#edit"
    # patch "passwordresets/:reset_token" => "passwordresets#update", as: :reset_password
  # end
  resources :posts do
    resources :favourites, only: [:create, :destroy]
    resources :comments
    resources :ratings, only: [:create, :update, :destroy]
  end
  resources :favourites, only: [:index]


end
