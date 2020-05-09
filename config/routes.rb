Rails.application.routes.draw do
  get 'animals/adoptions' => 'animals#adoptions'
  
  resources :enclosures
  resources :animals
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'animals#index'
end
