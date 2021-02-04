Rails.application.routes.draw do
  resources :movies, only: [:index, :show]
  resources :production_companies, only: [:index, :show]
end
