require_relative 'resque_dyno_scale_manager.rb'

namespace :resque do
  namespace :scale do
    desc 'Task to verifiy if Resque workers needs to be scaled up'
    task up: :environment do
      resque_manager = ResqueDynoScaleManager.new
      resque_manager.up_if_has_jobs_pending!
    end

    desc 'Task to verifiy if Resque workers needs to be scaled down'
    task down: :environment do
      resque_manager = ResqueDynoScaleManager.new
      resque_manager.down_if_has_no_jobs_pending_or_working!
    end
  end
end
