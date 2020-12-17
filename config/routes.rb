Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  resources :users, only:[:edit, :update, :show, :index]
  resources :books

end
