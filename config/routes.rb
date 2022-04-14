Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :public do
    get 'comments/create'
    get 'comments/destroy'
  end
 # 顧客用
# URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admins do
    root "toppages#index"
  end

  namespace :admin do
    resources :customers, only: [:show, :index, :edit, :update]
  end
  scope module: :public do
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    root "homes#top"
    get '/about' => 'homes#about'
    resources :customers, only: [:index,:show,:edit, :update]
    get 'customers/my_page' => 'customers#show'
    get 'customers/unsubscribe'
    get 'customers/withdraw'
    get "/search", to: "searchs#search"

    resources :tasks do
      resources :task_comments
      get 'tasks/reward',to: "tasks#reward"
      get 'confirm'
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create,:destroy]
    end
  end
end

