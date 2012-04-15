require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require Dir.pwd + '/classes/lastfm.rb'
require Dir.pwd + '/classes/imagebar.rb'
require 'ostruct'
require 'yaml'

set :env,  :production
#disable :run

configure do
  set :root, File.dirname(__FILE__)
  enable :static  
  enable :logging
  enable :dump_errors
  disable :sessions
end

get '/' do
  response['Cache-Control'] = "public, max-age=#{60*10}"
  erb :index
end

get '/play/:theme/:user' do
  theme_dir = Dir.pwd + '/themes/'
  user_name = params[:user]
  theme     = params[:theme]

  # check errors  
  halt [ 404, "Page not found" ]           unless user_name
  halt [ 500, "Sorry wrong theme" ]        unless theme
  halt [ 404, "Can't find themes file" ]   unless FileTest.exists? theme_dir + theme + '.yml'
  halt [ 404, "Can not found background" ] unless FileTest.exists? theme_dir + theme + '.gif'
  
  # read theme config
  conf = OpenStruct.new( YAML.load_file theme_dir + theme + '.yml' )
  
  # get last tracks from last.fm
  tracks = LastFM.get_tracks user_name

  # out headers and our image
  response['Cache-Control'] = "public, max-age=#{60*2}"
  content_type 'image/gif'
  ImageBar.draw theme_dir, theme, tracks, conf  
end
