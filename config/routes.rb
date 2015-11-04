Rails.application.routes.draw do

  devise_for :users
  resources :quotes

  root 'quotes#index'

  mount API => '/'

end