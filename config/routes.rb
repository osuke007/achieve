Rails.application.routes.draw do
  get 'comments/create'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
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

  root 'top#index'
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
