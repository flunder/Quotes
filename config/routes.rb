Rails.application.routes.draw do

  devise_for :users
  resources :quotes

  root 'user#index'

  match 'user/:id' => 'user#profile', :via => [:get]

  mount API => '/'

end