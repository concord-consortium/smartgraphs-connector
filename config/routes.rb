SmartgraphsConnector::Engine.routes.draw do
  get '/persistence/:learner_id' => 'persistence#show'
  post '/persistence/:learner_id' => 'persistence#update'
end
