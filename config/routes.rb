Rails.application.routes.draw do

  resources :quotes

  root 'quotes#index'

  mount API => '/'

end