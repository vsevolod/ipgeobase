require 'ipgeobase'

module Ipgeobase
  if defined? Rails
    require 'rails'
    class Railtie < Rails::Railtie
      rake_tasks do
        load "tasks/ipgeobase.rake"
      end
    end
  end
end
