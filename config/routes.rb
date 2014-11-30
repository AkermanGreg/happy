Happy::Application.routes.draw do

get 'logout', to: 'sessions#destroy', as: 'logout'

root 'welcome#index'

resources :sessions
resources :questions

get "videos/:question_id/new", to: "videos#new", as: :new_video
get "videos/index", to: "videos#index", as: :videos
post "videos/save", to: "videos#save", as: :save_video
post "videos/", to: "videos#upload", as: :create_video


get 'users/' => 'users#index', as: :users
get 'users/new' => 'users#new', as: :new_user
get 'users/:id' => 'users#show', as: :user
post 'users/' => 'users#create'
get 'users/:id/edit' => 'users#edit', as: :edit_user
patch 'users/:id' => 'users#update'
delete 'users/:id' => 'users#destroy'

 scope 'api', defaults: {format: :json} do
  get 'questions' => 'api#index', as: :api_questions
  get 'question/:id' => 'api#show', as: :api_question

 end


end
