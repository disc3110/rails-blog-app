Rails.application.routes.draw do

  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create ] do
      resources :comments, only: [:new, :create]
    end
  end

  get 'new', to: 'posts#new'
  put '/post/:id/like', to: 'posts#like', as: 'like'
  
end
