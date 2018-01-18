Rails.application.routes.draw do
  devise_for :users

  resources :charges, only: [:new, :create]

  resources :wikiis do
    resources :collaborators, only: [:create, :destroy]
  end

  resources :users, only: [:show] do
    member do
      get 'downgrade'
    end
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
