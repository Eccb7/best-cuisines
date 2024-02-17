Rails.application.routes.draw do
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  devise_for :users
    resources :users do
      member do
        delete 'sign_out_user', to: 'users#sign_out_user', as: :sign_out_user
      end
    end

  get "up" => "rails/health#show", as: :rails_health_check
  root "recipes#public_recipes"

  resources :foods, only: [:index, :create, :new, :destroy]

  resources :recipes do
    member do
      post 'toggle_public'
    end

    resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
  end

  get 'public_recipes', to: 'recipes#public_recipes', as: :public_recipes

  resources :public_recipes, only: :index, controller: 'recipes'

  resources :recipe_foods, only: [:new, :create]

  resources :users, only: [:index, :show, :edit, :update, :destroy]
end
