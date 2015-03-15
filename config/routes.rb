Rails.application.routes.draw do
  root 'links#index'

  get '/:token' => 'links#show', as: :link

  resource :links, only: [:create]
end
