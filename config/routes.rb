Rails.application.routes.draw do

  get 'searchs/search'
  get 'search/search'
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about" , as: "about"
  resources :users, only:[:edit, :update, :show, :index] do
    resource :relationships, only:[:create, :destroy]
    get "/follows" => 'relationships#follower', as: 'follows'
    get "/followers" => 'relationships#followed', as: 'followers'
  end
  resources :books, only:[:index, :show, :create, :update, :destroy, :edit] do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end

  get 'search' => 'searchs#search', as: 'search'
  resources :messages, :only => [:create, :show]
end
