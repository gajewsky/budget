# frozen_string_literal: true

Rails.application.routes.draw do
  resources :expenses, only: %i[index]
  resources :bills, only: %i[edit index new create update destroy]

  get 'warranty/', to: 'expenses#tracking'

  resources :categories, only: %i[edit index new create update destroy]

  resources :contractors

  resources :subcategories, only: :show

  resources :incomes

  devise_for :users, skip: [:registrations]

  root 'bills#new'
end
