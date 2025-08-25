Rails.application.routes.draw do
  namespace :admin do
      resources :carts
      resources :items
      resources :orders
      resources :pricing_rule_discountable_products
      resources :pricing_rule_required_products
      resources :products
      resources :product_items
      resources :product_pricing_rules

      root to: "carts#index"
    end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  resources :carts, only: [:new, :create, :show] do
    resources :orders, only: [:create, :destroy]
  end

  root "home#index"
end
