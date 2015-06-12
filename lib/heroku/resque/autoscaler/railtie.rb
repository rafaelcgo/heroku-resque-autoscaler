# lib/my_gem/railtie.rb
module Heroku
  module Resque
    module Autoscaler
      class Railtie < Rails::Railtie
        rake_tasks do
          load 'tasks/resque_dyno_scale_manager.rake'
        end
      end
    end
  end
end
