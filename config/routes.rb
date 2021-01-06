Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about" , as: "about"
  resources :users, only:[:edit, :update, :show, :index]
  resources :books, only:[:index, :show, :create, :update, :destroy, :edit] do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end

end
