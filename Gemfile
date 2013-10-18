source 'https://rubygems.org'

gem 'yajl-ruby'
gem 'rack'
gem 'pg'
gem 'em-http-request', :git => 'https://github.com/igrigorik/em-http-request.git'

gem 'em-postgresql-adapter', :git => 'git://github.com/leftbee/em-postgresql-adapter.git'
gem 'rack-fiber_pool',  :require => 'rack/fiber_pool'
gem 'em-synchrony', :git => 'git://github.com/igrigorik/em-synchrony.git',
                    :require => ['em-synchrony', 'em-synchrony/activerecord']
                            
gem 'grape'
gem 'goliath'

group :development do
  gem 'rake'
  gem 'guard', '~> 1.6.1'
  gem 'guard-bundler', '~> 1.0.0'
  gem 'guard-rack', '~> 1.2.2'
end

group :test do
  gem 'rspec', '~> 2.13.0'
  gem 'rack-test', '~> 0.6.2'
  gem 'capybara', '2.1.0'
  gem 'selenium-webdriver', '2.32.1'
  gem 'ZenTest', '4.9.4'
  gem 'rspec-autotest'
end