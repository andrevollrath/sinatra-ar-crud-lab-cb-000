require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/posts/new' do 
    erb :new
  end

  post '/posts' do
    Post.create(name: params[:name],content: params[:content])
    @posts = Post.all
    erb :index
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    post = Post.find(params[:id])
    post.update!(name: params[:name], content: params[:content])
    redirect to("/posts/#{post.id}")
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  get '/posts' do
    @posts = Post.all
    @msg = session[:msg]
    erb :index
  end

  delete '/posts/:id/delete' do
    post = Post.find(params[:id])
    session[:msg] = "#{post.name} was deleted"

    post.destroy
    redirect to("/posts")
  end

end