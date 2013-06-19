require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'active_support/all'


get '/' do
  redirect to('/videos')
end

get '/videos/new' do
  erb :new
end

post '/videos/create' do  
  title, description, url, genre = videosParamsPrep(params)
  sql_command = "INSERT INTO videos (title, description, url, genre) values (#{title}, #{description}, #{url}, #{genre});"
  run_sql(sql_command)
  redirect to('/videos')
end
 
get '/videos' do
  sql_command = 'SELECT * FROM videos'
  @rows = run_sql(sql_command)
  @genres = collectGenres
  erb :videos
end

get '/videos/byGenre/:genre' do
  genre = sqlStringPrep(params['genre'])
  sql_command = "SELECT * FROM videos WHERE genre=#{genre}"
  @rows = run_sql(sql_command)
  @genres = collectGenres
  erb :videos
end

get '/videos/:id/edit' do
  sql_command = "select * from videos where id=#{params['id']}"
  @row = run_sql(sql_command).first
  erb :edit
end

get '/videos/:id/delete' do
  sql_command = "DELETE FROM videos WHERE id=#{params['id']}"
  run_sql(sql_command)
  redirect to('/videos')
end

post '/videos/:id/update' do
  title, description, url, genre = videosParamsPrep(params)
  sql_command = "UPDATE videos SET title=#{title}, description=#{description}, url=#{url}, genre=#{genre} WHERE id=#{params['id']}"
  run_sql(sql_command)

  redirect to('/videos')
end


get '/contact' do
  erb :contact
end



def run_sql(sql_command)
  conn = PG.connect(dbname: 'videos_db', host: 'localhost')
  result = conn.exec(sql_command)
  conn.close
  result
end


def sqlStringPrep(str)
  str ||= 'NULL'
  str = 'NULL' if str == ''
  str.chomp!
  # str = str.gsub('"', '\"').gsub("'", "\'")
  str = '\'' + str + '\'' unless str=='NULL'
  return str
end


def videosParamsPrep(params)
  title = params[:title]
  description = params[:description]
  url = params[:url]
  genre = params[:genre]

  title = sqlStringPrep(title)
  description = sqlStringPrep(description)
  url = sqlStringPrep(url).gsub("http://", "")
  genre = sqlStringPrep(genre).downcase

  return title, description, url, genre
end


def collectGenres
  sql_command = 'SELECT genre FROM videos'
  rows = run_sql(sql_command)
  genres = []
  rows.each{|row| genres << row['genre']}
  return genres.uniq
end



# def createtTable()
#   sql_command = "create table videos (id serial8 primary key, title varchar(255), description text, url text, genre varchar(255));"
#   conn = PG.connect(dbname: 'dckli0k8nh4ndk', host: 'ec2-54-227-252-82.compute-1.amazonaws.com', user: 'pvmhnpkfkivhhq', password: 'ajSCm09X0lm48MnxzfH12Brgf2', port: '5432')
#   result = conn.exec(sql_command)
#   puts
#   puts result
#   puts
#   conn.close
#   result
# end





