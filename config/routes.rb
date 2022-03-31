Rails.application.routes.draw do

  devise_for :admin, controllers:{
    sessions: 'admins/sessions'
  }

  devise_for :end_users, controllers:{
    registrations: 'publics/registrations',
    sessions: 'publics/sessions'
  }

  namespace :admin do
    root 'homes#top'
    resources :items, only: [:index, :new, :create]
    #いらないかもしれないからshow edit updateはresourcesの中から以下に記述
    get "/items/:id"  => "items#show"
    get "/items/:id/edit"  => "items#edit"
    patch "/items/:id"  => "items#update"
    resources :genres, only: [:index, :create, :edit, :update]
    resources :end_users, only: [:index, :show, :edit, :update]
    #admin/orders
    resources :orders, only: [:show,:update]
    #admin/order_details
    resources :order_details, only: [:update]

  end

  scope module: :public do
    #コントローラ名
    #public/homes
    root 'homes#top'
    #public/items
    resources :items, only: [:index, :show]
    #public/end_users
    get  "end_users/mypage"  => "end_users#mypage"
    get  "/end_users/confirm" => "end_users#confirm"
    resource :end_users, only: [:edit, :update]
    patch '/withdraw' => 'end_users#withdraw', as: 'withdraw_end_user'
    put '/withdraw/' => 'end_users#withdraw'
    #public/cart_items
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete '/cart_items' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    #public/orders
    resources :orders, only: [:index, :new, :create]
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/complete' => 'orders#complete'
    get '/orders/:id' => 'orders#show'
    #public/addresses
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
