Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  
  root "welcome#index"

  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  resources :welcome, only: [:index]
  resources :my_posts, only: [:index]
  resources :my_comments, only: [:index]
  resources :tags

end
