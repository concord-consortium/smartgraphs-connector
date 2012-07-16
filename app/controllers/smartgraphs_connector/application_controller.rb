require 'authenticated_system'
require 'restricted_controller'

module SmartgraphsConnector
  class ApplicationController < ActionController::Base
    include ::AuthenticatedSystem
    include ::RestrictedController
  end
end
