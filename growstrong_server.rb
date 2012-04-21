require "sinatra"
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

get "/interviewee_sign_up" do
  erb :interviewee_sign_up
end

get "/interviewee_sign_up_submitted" do
  erb :interviewee_sign_up_submitted
end