module SmartgraphsConnector
  mattr_accessor :smartgraphs_runtime_url
  mattr_accessor :authoring_url

  class Engine < ::Rails::Engine
    isolate_namespace SmartgraphsConnector
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end
  end
end
