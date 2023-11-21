Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  resources :welcome, only: [:index, :new] do
    post 'upload_excel', on: :collection
  end
end