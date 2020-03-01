Rails.application.routes.draw do
  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    get '/signup', to: 'devise/registrations#new'
  end
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'pages#index'
  resources :posts do
    collection do
      get 'hobby'
      get 'study'
      get 'team'
    end
  end
  namespace :private do
    resources :conversations, only: [:create] do
      member do
        post :close
      end
    end

    resources :messages, only: [:index, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
