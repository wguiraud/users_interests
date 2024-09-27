require "sinatra"
require "sinatra/reloader" if development?
require "psych"

before do 
  @users = Psych.load_file("data/users.yaml")
end

helpers do 
  def comma_separated_interests(interests)
    interests.join(", ")
  end

  def other_users(current_user_name)
    @users.reject { |username| username == current_user_name.to_sym }
  end

  def count_interests
    @users.map { |name, _| @users[name][:interests].size}.sum
  end

end

get "/" do
  redirect "/users" 
end

get "/users" do 
  erb :users
end

get "/:user_name" do 
  user_name = params[:user_name].to_sym
  @user_email = @users[user_name][:email]
  @user_interests = @users[user_name][:interests]
  erb :user
end
