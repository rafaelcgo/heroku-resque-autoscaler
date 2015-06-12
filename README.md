# Heroku::Resque::Autoscaler

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'heroku-resque-autoscaler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heroku-resque-autoscaler

## Usage

Please provide these ENV Vars:
   HEROKU_APP_NAME
   HEROKU_OAUTH_TOKEN || HEROKU_API_KEY
   RESQUE_DYNO_SIZE (Defaults to '2x')
   RESQUE_DYNO_QUANTITY (Defaults to 1)

Then, just add 'resque:scale:up' 'resque:scale:down' tasks to your cron and enjoy autoscaling

## Contributing

1. Fork it ( https://github.com/rafaelcgo/heroku-resque-autoscaler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
