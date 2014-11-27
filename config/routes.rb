Happy::Application.routes.draw do

get 'logout', to: 'sessions#destroy', as: 'logout'

resources :sessions
resources :questions

root 'welcome#index'

get "video/new", to: "video#index", as: :new_video
post "video/", to: "video#upload", as: :create_video

get 'users/' => 'users#index', as: :users
get 'users/new' => 'users#new', as: :new_user
get 'users/:id' => 'users#show', as: :user
post 'users/' => 'users#create'
get 'users/:id/edit' => 'users#edit', as: :edit_user
patch 'users/:id' => 'users#update'
delete 'users/:id' => 'users#destroy'

end
