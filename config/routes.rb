Rails.application.routes.draw do
  get 'delivery_people/index'

  devise_for :users
  resources :users, :only=>[] do
    collection do 
      get :edit_profile
      patch :update_profile
    end
  end

  root "homes#index"

  resources :daily_forms do
    collection do
      delete 'delete_form_value/:id', :to=>'daily_forms#delete_form_value', 
                                                  :as=>'form_value'
      get :new_form_value
    end
  end

  resources :customer_routes do
    post :move
  end

  resources :customers do 
    collection do
      get :update_date
      get :delivery_routes
    end
  end

  namespace :admin do 
    resources :customers do
      member do
        post :set_status
      end
    end
    resources :manufacturers
    resources :delivery_people
    resources :users
    resources :user_permissions
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
