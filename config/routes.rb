# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'
  get 'dashboard/index'
  get 'dashboard/overall'

  resources :expenses, only: %i[index]
  resources :bills, only: %i[edit index new create update destroy]

  get 'tracking/', to: 'expenses#tracking'

  resources :categories, only: %i[edit index new create update destroy]

  resources :contractors

  resources :subcategories, only: :show

  resources :incomes

  devise_for :users, skip: [:registrations]

  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  root 'bills#new'

  resources :tags, except: :show

  get 'tags/:tag', to: 'tags#index'
end
