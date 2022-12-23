# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'recipes#index'

  resources :recipes, except: %i[edit update] do
    resources :recipe_foods, only: %i[new create destroy]
  end
  resources :foods, except: %i[edit update]

  get '/general_shopping_list', to: 'foods#general'
  get '/public_recipes', to: 'recipes#public'
end
