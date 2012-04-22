$requested_profiles = Array.new

get "/interviewer_sign_up" do
  erb :interviewer_sign_up
end

get "/search_for_validation" do
  erb :search_for_validation
end

post "/interviewer_sign_up_submitted" do
  erb :interviewer_sign_up_submitted
end

get "/check_validation_interview_order" do

  profile = {}
  profile[:gender] = params[:gender]
  profile[:age] = params[:age]
  profile[:income] = params[:income]
  profile[:products] = params[:products]
  profile[:expertise] = params[:expertise]
  profile[:adoption] = params[:adoption]
  profile[:voice_call] = params[:voice_call]

  $requested_profiles << profile

  puts $requested_profiles

  erb :check_validation_interview_order
end