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

  resources :posts do
    resources :comments
  end



end
