MarchMadness::Application.routes.draw do

  get "draft/index"

  get "draft/draft_player"

  get "draft/undraft_player"
  
  get "draft/get_current_draft_status"
  
  get "ncaa_players/get_by_ncaa_team"
  
  get "draft/get_eligible_players_by_round"

  get "home/player_scoring_details"
  
  get "mm_teams/get_roster"

  get "draft/start"

  get "draft/stop"

  resources :bracket

  resources :ncaa_teams

  resources :mm_teams

  resources :ncaa_players

  get "home/index"
  
  get "admin/index"
	post "admin/generate_draft_picks"
  get "draft/get_draft_picks"

  devise_for :users, :controllers => { :sessions => "sessions", :registrations => "registrations" }

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end