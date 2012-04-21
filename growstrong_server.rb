require "sinatra"
require "sinatra/cookies"
require "uuid"
require "json"
require "rack"

configure :development do
  Sinatra::Application.reset!
  use Rack::Reloader
end

set :public_folder, "./public"
set :views, "./views"

get "/" do
  erb :welcome
end