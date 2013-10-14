require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_record'
require_relative 'config/environments'
require_relative 'models/show'
require_relative 'models/song'

after do
  ActiveRecord::Base.clear_active_connections!
end


# Welcome to Broadway.ly!

get "/" do
  erb :'home'
end

# Index of all shows
# with links to individual shows

get "/shows" do
  @shows = Show.all
  @id = params[:id]
  erb :'shows/index'
end

# Form to create new show

get "/shows/new" do

  erb :'shows/new'
end

# Create action - new show - redirects to that
# show

post "/shows" do
  Show.create(title: params[:title], year: params[:year], composer: params[:composer], img_url: params[:img_url])
  redirect '/shows'
end

# Individual show page
# Links to list of all songs `/shows/:id/songs`
# and form to create new songs `/shows/:id/songs/new`

get "/shows/:id" do
  show = Show.find_by(id: params[:id]) 
  @title = show.title 
  @year = show.year 
  @composer = show.composer
  @img_url = show.img_url 
  erb :'shows/show'
end

# Form to create new songs

get "/shows/:id/songs/new" do
  @id = params[:id]
  erb :'songs/new'
end

# Create action - new songs for a show - redirects
# to that song

post "/shows/:id/songs" do
  show = Show.find_by(id: params[:id]) 
  @id = params[:id]
  Song.create(title: params[:title], embed_url: params[:embed_url], show_id: @id)
  
  redirect "/shows/#{show.id}/songs"
end

# Lists all songs from the show

get "/shows/:id/songs" do
  @songs = Song.all
  @songster = Song.where(show_id: params[:id])
  erb :'songs/index'
end

# Shows just one song from the show

get "/shows/:show_id/songs/:song_id" do
    @song_title = single_song.title 
    @song_embed = single_song.embed_url 
  erb :'songs/show'
end


