Rails.application.routes.draw do
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

  root 'finance_log_analy#index'

  #storm-kafka
  get 'finance_log_analy/index_general_chart' => 'finance_log_analy#index_general_chart'
  get 'finance_log_analy/index_submit_action_chart' => 'finance_log_analy#index_submit_action_chart'
  get 'finance_log_analy/user_pay_times_detail/:count_enum' => 'finance_log_analy#user_pay_times_detail',as: :user_pay_times_details

  #accounting
  #login
  get 'accounting/login' => 'accounting#login'
  post 'accounting/login_submit' => 'accounting#login_submit'
  post 'accounting/login_out' => 'accounting#login_out'
  get 'accounting/index' => 'accounting#index'
  get 'accounting/new' => 'accounting#new'
  post 'accounting/new_submit' => 'accounting#new_submit'
  post 'accounting/:ar_id/delete_submit' => 'accounting#delete_submit', as: :accounting_delete_submit
  post 'accounting_user_sync_record' => 'accounting#user_sync_record'
end
