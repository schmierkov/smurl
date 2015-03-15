Rails.application.routes.draw do
  root 'links#index'

  get '/:token' => 'links#show'

  resource :links, only: [:create]
end
