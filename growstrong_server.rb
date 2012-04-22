require "sinatra"
require "uuid"
require "json"
require "rack"

configure :development do
  Sinatra::Application.reset!
  use Rack::Reloader
end

$Interviewees = Array.new

set :public_folder, "./public"
set :views, "./views"

get "/" do
  erb :welcome
end

get "/interviewee_sign_up" do
  erb :interviewee_sign_up
end

get "/view_validators_and_visionaries" do
    erb :view_validators_and_visionaries
end

get "/returning_interviewee" do
  erb :interviewee_sign_in
end

post "/interviewee_sign_up_submitted" do

  survey = {}

  survey[:email] = params[:email]
  survey[:pass] =  params[:pass]
  survey[:paypal_id]= params[:paypal_id]
  survey[:gender] = params[:gender]
  survey[:age] = params[:age]
  survey[:income] = params[:income]
  survey[:products] = params[:products]
  survey[:expertise] = params[:expertise]
  survey[:adoption] = params[:adoption]
  survey[:voice_call] = params[:voice_call]

  $Interviewees << survey

  erb :interviewee_sign_up_submitted
end

post "/interviewee_sign_in_submitted" do

  username = params[:email]
  password = params[:password]

  result = $Interviewees.select{|user| user[:email] == username}.first

  if((!result.nil?) && result.count > 0 )

    if(result[:pass] == password)
      return "You're in"
    else
      return "Invalid password"
    end
  end

  return "You don't exist"

  end
