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

get "/interviewer_sign_up" do
  erb :interviewer_sign_up
end

post "/interviewee_sign_up_submitted" do
  erb :interviewee_sign_up_submitted
end

post "/interviewer_sign_up_submitted" do
  erb :interviewer_sign_up_submitted
end

get "/search_for_validation" do
  erb :search_for_validation
end

get "/check_validation_interview_order" do
  erb :check_validation_interview_order
end