Rails.application.routes.draw do
  get 'users/new'

  root 'welcome#index'

  resources :users do
    get :blogs, on: :member
  end

  resources :sessions

  resources :blogs do
    resources :comments
  end

  

  namespace :admin do
  	root 'users#index'
  	resources :users do
  		collection do
  			get :search
  		end
  	end
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
