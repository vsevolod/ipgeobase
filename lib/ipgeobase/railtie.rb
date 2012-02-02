require 'ipgeobase'
require 'rails'
module Ipgeobase
  class Railtie < Rails::Railtie
    rake_tasks do
      require 'tasks/ipgeobase.rake'
    end
  end
end
