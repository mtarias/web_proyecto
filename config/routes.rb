Eventmaker::Application.routes.draw do
  get "home/index"

  match 'login' => "home#login", :as => :login
  match 'profile(/:email)' => "home#profile", :as => :profile
  match 'logout' => "home#logout", :as => :logout

  match 'assist(/:id)' => "events#assist", :as => :assist
  match 'not_attend(/:id)' => "events#not_attend", :as => :not_attend
  match 'invite(/:id(/:guest_id))' => "events#invite", :as => :invite
  
  resources :groups do
    collection do
      post 'add_members'
    end
  end

  resources :pictures

  resources :events do  
    resources :event_comments
    resources :pictures
    resources :taxes
    collection do
      get 'own'
      get 'next'
      get 'past'
      get 'public'
      post 'send_invitations'
    end
  end

  resources :users do
    resources :user_taxes
    collection do
      get 'search'
      get 'search_group'
      get 'check_email'
    end
  end

  resources :api_authentication, :only => [:create]

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
