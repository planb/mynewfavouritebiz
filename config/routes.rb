ActionController::Routing::Routes.draw do |map|
  
  map.resources :tags, :businesses
  map.resources :features, :collection => { :completed => :put }
  map.resource  :session
  
  map.resources :users do |users|
    users.resources :friends, :collection => { :accept_friendship => :put }
  end
  
  map.home '', :controller => 'home', :action => 'index'
  map.search '/search', :controller => 'search', :action => 'index'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'session', :action => 'new'
  map.logout '/logout', :controller => 'session', :action => 'destroy'
  
  map.open_id_complete 'session', :controller => 'session', :action => 'create', :requirements => { :method => :get }
  
  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
