require 'rubygems'
require 'sinatra'
require 'datamapper'
require 'sqlite3'

DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/db/tasks.sqlite")

class Task
  include DataMapper::Resource
  property :id,          Serial
  property :name,        Text
  property :description, Text
  property :due,         Date
  property :category,    Text
  property :completed,   Boolean,  :default => false
end

helpers do
  def checked(value)
    params[:completed]
  end
end

# index
get '/' do
  @tasks = Task.all
  haml :index
end

# new
get '/new' do
  haml :new
end

# create
post '/create' do
  @task = Task.new
  @task.attributes = {:name         => params[:name], 
                      :description  => params[:description],
                      #:due         => params[:due],
                      :category     => params[:category]}
  if @task.save
    redirect '/'
  else
    @errors = []
    @task.errors.each { |error| @errors << error }
    redirect '/new'
  end
end

# edit
get '/edit/:id' do
  @task = Task.get!(params[:id])
  haml :edit
end

put '/edit/:id' do
  @errors = params[:errors]
  @task = Task.get!(params[:id])
  if @task.update_attributes(:name         => params[:name],
                             :description  => params[:description],
                             #:due         => params[:due],
                             :category     => params[:category],
                             :completed    => params[:completed])
    redirect "/#{@task.id}"
  else
    redirect '/edit/:id'
  end
end

# destroy
get '/destroy/:id' do
  @task = Task.get!(params[:id])
  @task.destroy
  redirect '/'
end

# show
get '/:id' do
  @task = Task.get!(params[:id])
  haml :show
end

# Routes for static files
get '/main.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :main
end