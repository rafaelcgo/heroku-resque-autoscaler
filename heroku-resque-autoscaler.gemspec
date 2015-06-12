# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heroku/resque/autoscaler/version'

Gem::Specification.new do |spec|
  spec.name          = "heroku-resque-autoscaler"
  spec.version       = Heroku::Resque::Autoscaler::VERSION
  spec.authors       = ["Rafael Oliveira"]
  spec.email         = ["rafael.coelho@gmail.com"]
  spec.summary       = %q{Rake task to scale Heroku Dyno Resque workers.}
  spec.description   = %q{Just add 'resque:scale:up' 'resque:scale:down' tasks to your cron and enjoy autoscaling}
  spec.homepage      = "https://github.com/rafaelcgo/heroku-resque-autoscaler"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "resque"
  spec.add_runtime_dependency "platform-api"
end
