require "sinatra"
require "uuid"
require "json"
require "rack"
require "mongo"

enable :sessions

$db = Mongo::Connection.new("ds029287.mongolab.com", 29287).db("leancentipede")
$db.authenticate("humancentipede", "abc123!")
$validators = $db.collection("validators")
$visionaries = $db.collection("visionaries")
$profile_requests = $db.collection("profile_requests")

configure :development do
  Sinatra::Application.reset!
  use Rack::Reloader
end

set :public_folder, "./public"
set :views, "./views"

get "/" do
  erb :welcome
end

get "/validator_sign_up" do
  erb :validator_sign_up
end

get "/view_validators_and_visionaries" do
    @visionaries = $visionaries.find({}).to_a
    @validators = $validators.find({}).to_a
    @profile_requests = $profile_requests.find({}).to_a
    erb :view_validators_and_visionaries
end

get "/returning_validator" do
  erb :validator_sign_in
end

post "/validator_sign_up_submitted" do
  insert_validator(params, false)
  erb :validator_sign_up_submitted
end

def insert_validator(params, replace)
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
  survey[:max_questions] = params[:max_questions]

  if(checkForExisting($validators, survey[:email], survey[:password]))
    if(!replace)
      @message = "That email address is already in use!"
      return erb :validator_sign_up
    else
      $validators.remove(:email=> survey[:email])
    end
  else
    session[:email] = params[:email]
  end

  $validators.insert(survey, :safe=>true)

end

post "/validator_sign_in_submitted" do
  username = params[:email]
  password = params[:password]

  result = $validators.find({:email=> username}).first

  if((!result.nil?) && result.count > 0 )
    if(result["pass"] == password)
      session[:email] = username
      redirect '/validator_home'
    else
      @message = "Invalid username or password"
      return erb :validator_sign_in
    end
  end

  @message = "Invalid username or password 2"
  return erb :validator_sign_in

end

get "/visionary_sign_up" do
  erb :visionary_sign_up
end

get "/returning_visionary" do
  erb :visionary_sign_in
end

get "/visionary_signed_in" do

      redirect "/visionary_home"
end

get "/visionary_home" do
  @requests = $profile_requests.find(:visionary_email => session[:visionary_email]).to_a
  erb :visionary_signed_in
end

get "/visionary_sign_in_submitted" do
    redirect "/returning_visionary" if session[:visionary_email] == nil
    redirect '/visionary_signed_in'
end

post "/visionary_sign_in_submitted" do
  username = params[:email]
  password = params[:password]

  result = $visionaries.find({:email=> username}).first

  if((!result.nil?) && result.count > 0 )
    if(result["password"] == password)
      session[:visionary_email] = result["email"]
      redirect "/visionary_signed_in"
    else
      @message = "Invalid username or password"
      redirect "/returning_visionary"
    end
  end

  @message = "Invalid username or password"
  redirect "/returning_visionary"

end

get "/search_for_validation" do
  erb :search_for_validation
end

post "/visionary_sign_up_submitted" do

  visionary = {}

  visionary[:email] = params[:email]
  visionary[:password] = params[:password]

  if(checkForExisting($visionaries, visionary[:email], visionary[:password]))
    @message = "That email address is already in use!"
    return erb :visionary_sign_up
  end

  $visionaries.insert(visionary, :safe=>true)
  session[:visionary_email] = visionary[:email]
  erb :visionary_sign_up_submitted
end

get "/validator_home" do

  @validator = $validators.find({:email=> session[:email]}).first

  return erb :validator_home
end

get "/check_validation_interview_order" do
    erb :visionary_sign_up_submitted
end

post "/validator_update_submitted" do
  insert_validator(params, true)

  redirect "/validator_home"
end

post "/check_validation_interview_order" do
  profile = {}

  profile[:visionary_email] = session[:visionary_email]
  profile[:name] = params[:name]
  profile[:gender] = params[:gender]
  profile[:age] = params[:age]
  profile[:income] = params[:income]
  profile[:products] = params[:products]
  profile[:expertise] = params[:expertise]
  profile[:adoption] = params[:adoption]
  profile[:voice_call] = params[:voice_call]

  $profile_requests.insert(profile, :safe=>true)

  erb :visionary_sign_up_submitted
end

def checkForExisting(collection, email, password)

  result = collection.find({:email=> email}).first

  !result.nil?
end