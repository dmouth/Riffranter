RiffRanter::Application.routes.draw do
  match "/prw/update_widget" => "persona_rant_widget#update_widget", :via => :get
  match "/prw/category_changed" => "persona_rant_widget#category_changed", :via => :get
  match "/prw/persona_changed" => "persona_rant_widget#persona_changed", :via => :get
  
  match "/home/latest_rants" => "home#latest_rants", :via => :get
  match "/home/hot_rants" => "home#hot_rants", :via => :get
  match "/home/subscriber_rants" => "home#subscriber_rants", :via => :get

  match "persona_rant_widget/new_persona_rant(.:format)" => "persona_rant_widget#new_persona_rant", :via => :post
  match "persona_rant_widget/new_rant(.:format)" => "persona_rant_widget#new_rant", :via => :post

  resources :rants, :except => :index do
    member do
      post :add_vote
      post :destroy
    end

    collection do
      get :latest
      get :subscriber
      get :more_latest
      get :more_subscriber
    end
  end

  resources :categories
  resources :personas do
    member do
      post :follow
      post :unfollow
    end
  end

  # ==============
  # = User Stuff =
  # ==============
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"

  resources :users do
    member do
      post :follow
      post :unfollow
    end
  end

  resources :sessions
  
  root :to => "home#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
