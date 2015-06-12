require 'platform-api'
require 'resque'

# Use HEROKU_OAUTH_TOKEN or HEROKU_API_KEY to connect to heroku API
# ENV VARS TO BE SET:
#   HEROKU_APP_NAME
#   HEROKU_OAUTH_TOKEN || HEROKU_API_KEY
#   RESQUE_DYNO_SIZE
#   RESQUE_DYNO_QUANTITY
class ResqueDynoScaleManager
  def initialize
    @proccess_name = 'resque'
    @app_name      = ENV['HEROKU_APP_NAME']

    @resque_dyno_size     = ENV['RESQUE_DYNO_SIZE']     || '2X'
    @resque_dyno_quantity = ENV['RESQUE_DYNO_QUANTITY'] || 1

    if ENV['HEROKU_OAUTH_TOKEN']
      @heroku = PlatformAPI.connect_oauth(ENV['HEROKU_OAUTH_TOKEN'])
    else
      @heroku = PlatformAPI.connect(ENV['HEROKU_API_KEY'])
    end
  end

  def down_if_has_no_jobs_pending_or_working!
    tag = '[rake][down_if_has_no_jobs_pending_or_working!]'
    puts "#{tag} Starting..."

    info = check_info(tag)
    check_queues(tag)

    if info[:pending].to_i + info[:working].to_i > 0
      puts "#{tag} Working or Pending... Can't scale down."
    else
      puts "#{tag} Not Working. Scaling down..."
      self.down!
    end
  end

  def up_if_has_jobs_pending!
    tag = '[rake][up_if_has_jobs_pending!]'
    puts "#{tag} Starting..."

    info = check_info(tag)
    check_queues(tag)

    if info[:pending] > 0
      puts "#{tag} Jobs found. Scaling up..."
      self.up!
    else
      puts "#{tag} No job found. No need to scale up."
    end
  end

  # private
  def check_info(tag)
    info = Resque.info
    puts "#{tag} #{info.inspect}"
    info
  end

  def check_queues(tag)
    puts "#{tag} Checking Queues: #{Resque.queues}"
    Resque.queues.each do |q|
      puts "#{tag} Queue: #{q} | Jobs: #{Resque.size(q)}"
    end
  end

  def down!
    puts '[rake][down!] Scaling down...'
    @heroku.formation.update(@app_name, @proccess_name, quantity: 0)
  end

  def up!
    puts '[rake][up!] Scaling up...'
    @heroku.formation.update(
      @app_name, @proccess_name,
      size: @resque_dyno_size, quantity: @resque_dyno_quantity.to_i
    )
  end
end
