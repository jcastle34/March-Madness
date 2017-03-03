MarchMadness::Application.routes.draw do

  get "draft/index"
  get "draft/draft_player"
  get "draft/undraft_player"
  get "draft/results"
  get "draft/get_current_draft_status"
  get "ncaa_players/get_by_ncaa_team"
  get "draft/get_eligible_players_by_round"
  get "draft/get_preferred_players_by_round"
  get "home/player_scoring_details"
  get "mm_teams/get_roster"
  get "mm_teams/rosters"
  get "draft/start"
  get "draft/stop"
  post "bracket/update_regions"
  get "home/index"
  get "admin/index"
  get "admin/bracket"
	post "admin/generate_draft_picks"
  get "draft/get_draft_picks"
  get "ncaa_teams/rosters"

  namespace :admin do
    resources :ncaa_players
    resources :ncaa_teams
  end

  resources :bracket
  resources :ncaa_teams
  resources :ncaa_players
  resources :player_scoring

  resources :mm_teams do
    member do
      get "preferred_players", :as => "preferred_players", :action => :preferred_players
      get "add_preferred_player", :as => "add_preferred_player", :action => :add_preferred_player
      get "remove_preferred_player", :as => "remove_preferred_player", :action => :remove_preferred_player
      get "get_preferred_players_by_round", :as => "get_preferred_players_by_round", :action => :get_preferred_players_by_round
      get "get_eligible_players_by_round", :as => "get_eligible_players_by_round", :action => :get_eligible_players_by_round
    end
  end

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
