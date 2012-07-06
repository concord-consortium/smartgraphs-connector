Rails.application.routes.draw do

  mount SmartgraphsConnector::Engine => "/smartgraphs_connector"
end
