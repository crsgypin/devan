Rails.application.routes.draw do
  get 'delivery_people/index'

  devise_for :users

  root "homes#index"

  resources :daily_forms do

    member do
      get :edit_form1
      get :show_form1
      patch :update_form1
      get :new_form1_value
      delete 'delete_form1_value/:form_value_id', :to=>'daily_forms#delete_form1_value', 
                                                  :as=>'form1_value'
      
      get :edit_form2
      get :show_form2
    end

    member do
      get :add_row
      get :print
    end
  end

  resources :customer_routes do
    post :move

  end

  resources :customers do 
    collection do
      get :update_date

      get :profiles
      get :deliveried_days
      get :delivery_plan_days
    end

    member do
      post :update_status
    end
  end

  resources :delivery_people do 
    member do
      get :form_values
    end
  end
  resources :manufacturers
  resources :cities
  resources :districts


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
