require "sinatra"
require "sinatra/activerecord"
set :database, "sqlite3:myblogdb.sqlite3"
require "./models"
#require "sinatra/flash"

enable :sessions

def current_user()
    if session[:user_id]
        @current_user = User.find(session[:user_id])
    end
end
get '/index' do
 erb :index   
    end 

post '/index' do
    @user = current_user
    @newpost = Post.new(body: params[:body], user_id: @user.id)
    if !@post.save
    redirect '/index'
    end
end

get '/' do
    @posts = Post.all
    erb :index
end

get '/user' do
    @user = current_user
    @posts = @user.posts
    erb :user
end

get '/delete' do
    @user = current_user
    @posts = @user.posts
    erb :'delete-user'
 end


get '/newpost' do
    erb :newpost
end


post '/newpost' do
    @user = current_user
	puts params.inspect
    @post = Post.new(body: params[:body], user_id:
     @user.id)
    if !@post.save
        redirect '/newpost'
    else
        redirect '/'
      #  flash[:notice] = "Post too long!"    
    end
end

get '/posts/:id' do
    @post = Post.find(params[:user_id])
    erb :newpost
end

get '/signin' do
    erb :signin
end

post '/signin' do
    @user = User.where(email: params[:email]).first 
    puts params.inspect
    puts @user.inspect  
    if @user && @user.password == params[:password] 
        session[:user_id] = @user.id    
        redirect '/user'   
    else     
        redirect '/signin'
     #   flash[:notice] = "Incorrect username or password; try again." 
    end
end

get '/signup' do
	@firstname = User.new
	@lastname = User.new
	@email = User.new
    @password = User.new

	erb :signup
end

post '/signup' do
    @user = User.new(firstname: params[:firstname], lastname: params[:lastname],
    	email: params[:email], password: params[:password])
    @user.save
    session[:user_id]=@user.id
	redirect '/newpost'
	erb :signup
end

get '/signout' do 
    session.clear
    erb :signin
end

