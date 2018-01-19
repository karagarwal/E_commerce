Rails.application.routes.draw do
  get 'welcome/index'
    resources :users
    resources :categories
    resources :items
    resources :orders
    resources :invoices
  root 'welcome#index'
end
