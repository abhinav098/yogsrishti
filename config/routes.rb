Rails.application.routes.draw do

  root 'static_pages#home'
  resources :asanas do
    collection do
      get :search
    end
  end

  devise_for :users
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get 'terms', to: 'static_pages#terms'

end
