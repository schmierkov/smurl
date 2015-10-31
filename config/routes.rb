Rails.application.routes.draw do
  root 'links#index'

  resource :links, only: [:create]
  resources :listings, only: [:index]

  get '/:token' => 'links#show', as: :link
end
