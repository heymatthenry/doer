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