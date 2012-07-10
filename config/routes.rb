SmartgraphsConnector::Engine.routes.draw do
  get '/persistence' => 'persistence#check'
  get '/persistence/:learner_id' => 'persistence#show', :constraints => {:learner_id => /\d+/}
  post '/persistence/:learner_id' => 'persistence#update', :constraints => {:learner_id => /\d+/}
end
