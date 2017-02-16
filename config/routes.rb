Rails.application.routes.draw do
  root 'top#index'
  get 'relationships/create'
  get 'relationships/destroy'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :conversations do
    resources :messages
  end

  resources :blogs, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
  end

  resources :contacts, only:[:index, :new, :create, :destroy]do
    collection do
      post :confirm
    end
  end

  resources :users, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  resources :poems, only: [:index, :show]

  resources :blogs do
    resources :comments

    collection do
      post :confirm
    end
  end
end
