require "sinatra"
require "sinatra/cookies"
require "uuid"
require "json"

set :public_folder, "./public"
set :views, "./views"

get "/" do
  erb :welcome
end