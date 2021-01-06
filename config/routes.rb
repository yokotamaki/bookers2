Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about" , as: "about"
  resources :users, only:[:edit, :update, :show, :index]
  resources :books, only:[:index, :show, :create, :update, :destroy, :edit] do
    resource :favorites, only:[:create, :destroy]
  end

end
