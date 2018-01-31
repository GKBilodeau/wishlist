Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'lists#home'
  get '/lists/new' => 'lists#new'
  get '/lists/index' => 'lists#index'
  post '/lists' => 'lists#create'
  get '/lists/:id/edit' => 'lists#edit'
  delete '/lists/:id' => 'lists#destroy'
  patch '/lists/perm_mod' => 'lists#perm_mod'
  patch '/lists/wish_del' => 'lists#wish_del'
  patch '/lists/perm_del' => 'lists#perm_del'
  patch '/lists/buy' => 'lists#buy'
  patch '/lists/:id' => 'lists#update'
  get '/lists/search' => 'lists#search'
  get '/lists/:id/show' => 'lists#show'
end
