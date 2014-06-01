Angelhack::Application.routes.draw do
  resources :map_layers
  resources :census_tracts

  root 'home#index'
end
