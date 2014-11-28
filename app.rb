require 'sinatra'
require 'haml'
require 'better_errors'
require 'coffee_script'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

get '/' do
  @title = 'HAML Test'
  haml :index
end

get '/:title' do |title|
  @title = title
  haml :index
end
