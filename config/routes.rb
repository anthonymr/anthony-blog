Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
    end
  end

  put '/posts/:id/add_like', to: 'posts#add_like', as: 'add_like'
  root 'users#index'
end
