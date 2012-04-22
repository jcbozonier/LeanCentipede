require "sinatra"
require "uuid"
require "json"
require "rack"
require "mongo"

$db = Mongo::Connection.new("ds029287.mongolab.com", 29287).db("leancentipede")
$db.authenticate("humancentipede", "abc123!")
$validators = $db.collection("validators")
$profile_requests = $db.collection("profile_requests")

class ValidatorStore
  def initialize
    @db = Mongo::Connection.new("ds029287.mongolab.com", 29287).db("leancentipede")
    @db.authenticate("humancentipede", "abc123!")
    @analysis_events = @db.collection("validators")
  end

  def persist validator
    @analysis_events.insert(validator, :safe=>true)
  end

  def get_all_events_for analysis_id
    results = Array.new
    @analysis_events.find({:analysis_id => analysis_id}).sort([['version',1]]).to_a
  end

  def get_all_events
    @analysis_events.find({}).to_a
  end

  def create_event_store_for analysis_id

  end
end

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

get "/view_validators_and_visionaries" do
    @validators = $validators.find({}).to_a
    @profile_requests = $profile_requests.find({}).to_a
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

  $validators.insert(survey, :safe=>true)

  erb :interviewee_sign_up_submitted
end

post "/interviewee_sign_in_submitted" do

  username = params[:email]
  password = params[:password]

  result = $validators.select{|user| user[:email] == username}.first

  if((!result.nil?) && result.count > 0 )

    if(result[:pass] == password)
      return "You're in"
    else
      return "Invalid password"
    end
  end

  return "You don't exist"

end
