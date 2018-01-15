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

#Run the application
run App

