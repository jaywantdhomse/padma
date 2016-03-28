Rails.application.routes.draw do

  resources :vacancies

  resources :products

  resources :categories

  resources "applicants", only: [:new, :create]
  #devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#home'
  devise_for :users, :controllers => {:registrations => "registration", :sessions => "devisesession", :passwords => 'passwords', :confirmations => "confirmation"}
  
  match "show_category_products" => "products#show_category_products", via: [:get, :post]
  match "order_product" => "products#order_product", via: [:get, :post]
  match "contact_us" => "home#contact_us", via: [:get, :post]
  match "distributor_complaint" => "home#distributor_complaint", via: [:get, :post]
  match "applicant_submit" => "home#applicant_submit", via: [:get, :post]
  match "new" => "home#new", via: [:get]
  match "home" => "home#home", via: [:get]
  match "about_us" => "home#about_us", via: [:get]
  match "contact" => "home#contact", via: [:get]
  match "distributor" => "home#distributor", via: [:get]
  match "applicant" => "home#applicant", via: [:get]
  match "product" => "home#product", via: [:get]
  match "category" => "home#category", via: [:get]
  match "get_product_details" => "products#get_product_details", via: [:post]

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
