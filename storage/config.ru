#Use bundler to load gems
require 'bundler'

#Load gems from Gemfile
Bundler.require

#Load the app
require_relative 'storage.rb'

#
Slim::Engine.set_options pretty: true, sort_attrs: false

#
#enable :sessions

#Load models
require_relative 'ORM/orm.rb'
require_relative 'ORM/sharedcontent'
require_relative 'ORM/users'
require_relative 'ORM/usercontent'
#Run the application
run App

