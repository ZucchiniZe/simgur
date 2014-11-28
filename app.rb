require 'sinatra'
require 'haml'
require 'better_errors'
require 'coffee_script'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

def rand_string
  o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
  string = (0...8).map { o[rand(o.length)] }.join
end

get '/' do
  @title = 'HAML Test'
  haml :index
end

get '/rand' do
  @title = "Random string generator"
  @rand = rand_string
  puts "rand: #{@rand}"
  haml :rand
end

get '/upload' do
  @title = "Imgur Clone"
  haml :upload
end

post '/upload' do
  @name = rand_string

  File.open("./public/#{@name}.png", "w") do |f|
    f.write(params['myfile'][:tempfile].read)
  end

  redirect to("/#{@name}")
end

get '/:img' do |img|
  @title = "Image"
  @img = "/#{img}.png"
  @link = "#{request.host}#{@img}"
  haml :img
end
