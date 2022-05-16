Rails.application.routes.draw do

  namespace :admin do
    resources :task_comments, only: [:index,:destroy]
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

  namespace :admin do
    resources :customers, only: [:index,:show, :edit, :update]
  end
  scope module: :public do
      get '/homes/guest_sign_in', to: 'homes#guest_sign_in'
      root "homes#top"

    resources :customers, only: [:index,:show,:edit,:update] do
      member do
        get :favorites
      end
    end
    get 'customers/my_page' => 'customers#show'
    get 'customers/:id/unsubscribe' =>'customers#unsubscribe',as: 'customer_unsubscribe'
    patch 'customers/:id/withdraw'  =>'customers#withdraw',as: 'customer_withdraw'
    post '/tasks/:id/done' => 'tasks#done',   as: 'done'


    resources :tasks do
      resources :task_comments, only: [:create,:destroy]
      resources :cards
      get 'tasks/reward',to: "tasks#reward"
      resource :favorites, only: [:create,:destroy]
    end
  end
end