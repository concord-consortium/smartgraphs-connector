Rails.application.routes.draw do

  mount SmartgraphsConnector::Engine => "/smartgraphs_connector"

  match '/home' => 'home#index', :as => :home
  root :to => 'home#index'
end
