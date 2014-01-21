class MoviesController < ApplicationController

# We don't have a real DB. Let's fake data: movie_db is class variable with movie data
@@movie_db = [
          {"Title"=>"The Matrix", "Year"=>"1999", "imdbID"=>"tt0133093", "Type"=>"movie"},
          {"Title"=>"The Matrix Reloaded", "Year"=>"2003", "imdbID"=>"tt0234215", "Type"=>"movie"},
          {"Title"=>"The Matrix Revolutions", "Year"=>"2003", "imdbID"=>"tt0242653", "Type"=>"movie"},        ]


# route: GET    /movies(.:format)          movies#index
def index
  # create instance variable that references all movies
  @movies = @@movie_db
  # by default, renders: movies/index.html.erb
end

# GET    /movies/:id(.:format)      movies#show
def show
  # find movie to show, get id from params
  @movie = @@movie_db.find do |m|
    m["imdbID"] == params[:id]
  end

  if @movie.nil?
    flash.now[:message] = "Movie not found" if @movie.nil?
    @movie = {}
  end
  # by default, renders: movies/show.html.erb
end

# GET    /movies/new(.:format)      movies#new
def new
  # by default, renders: movies/new.html.erb
end

# POST   /movies(.:format)          movies#create
def create
  # handles form submit
  # create new movie object
  movie = {"Title" => params[:title] , "Year" => params[:year], "imdbID" => rand(10000..100000000).to_s }
  # add object to movie db
  @@movie_db << movie
  # show movie page
  redirect_to action: :show,  id: movie["imdbID"]
end

# GET    /movies/:id/edit(.:format) movies#edit
def edit
  @movie = @@movie_db.find do |m|
    m["imdbID"] == params[:id]
  end

  if @movie.nil?
    flash.now[:message] = "Movie not found" if @movie.nil?
    @movie = {}
  end
end

# DELETE /movies/:id(.:format)      movies#destroy
def destroy
  @@movie_db.delete_if do |m|
    m["imdbID"] == params[:id]
  end
  redirect_to action: :index
end

# PATCH  /movies/:id(.:format)      movies#update
def update
  puts "UPPPPDATE"
  #implement
    @@movie_db.delete_if do |m|
    m["imdbID"] == params[:id]
  end

  #update movie
  movie = {}
  movie["imdbID"] = params[:id]
  movie["Title"] = params[:title]
  movie["Year"] = params[:year]

  @@movie_db << movie

  redirect_to action: :index
end

end