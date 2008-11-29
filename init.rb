require 'rubygems'
require 'sinatra'
require 'datamapper'
require 'sqlite3'

DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/db/tasks.sqlite")

class Task
  include DataMapper::Resource
  property :id,          Serial
  property :name,        String
  property :description, Text
end

get '/new' do
  haml :new
end

post '/create' do
  @task = Task.new
  @task.attributes = {:name => params[:name], :description => params[:description] }
  @task.save
end