
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'active_support/all'
require 'digest/md5'

puts "development? #{development?}"
puts "production? #{production?}"

def run_sql(sql)
  conn = PG.connect(:dbname => 'friends_db', :host => 'localhost')
  result = conn.exec(sql)
  conn.close
  return result
end

get '/' do
  @rows = run_sql("SELECT * FROM friends")
  erb :home
end

get '/trash/:id' do
  sql = "DELETE FROM friends WHERE id=#{params[:id]}"
  run_sql(sql)
  redirect to('/friends')
end

get '/new' do
  erb :new
end

get '/friends' do
  @rows = run_sql("SELECT * FROM friends")
  erb :friends
end


post '/create' do
  puts params

  name = params[:name]
  age = params[:age]
  gender = params[:gender]
  image = params[:image]
  twitter = params[:twitter]
  github = params[:github]
  facebook = params[:facebook]
  website = params[:website]
  email = params[:email]
  phone = params[:phone]

  age ||= 'NULL'
  age = age.to_i unless age=='NULL'
  age = 'NULL' if age == 0

  name = sqlStringPrep(name)
  gender = sqlStringPrep(gender)
  image = sqlStringPrep(image).gsub("http://", "")
  twitter = sqlStringPrep(twitter).gsub("http://", "")
  puts twitter
  github = sqlStringPrep(github).gsub("http://", "")
  facebook = sqlStringPrep(facebook).gsub("http://", "")
  website = sqlStringPrep(website).gsub("http://", "")
  email = sqlStringPrep(email)
  phone = sqlStringPrep(phone)


puts image
puts image
puts image
puts image

  image = sqlStringPrep(imageHandler(email[1..(email.length-2)])) if (image=='NULL' && email!='NULL')

  sql = "INSERT INTO friends (name, age, gender, image, twitter, github, facebook, website, email, phone) VALUES (#{name}, #{age}, #{gender}, #{image}, #{twitter}, #{github}, #{facebook}, #{website}, #{email}, #{phone});"

  run_sql(sql)

  redirect to('/friends')

end


def sqlStringPrep(str)
  str ||= 'NULL'
  str = 'NULL' if str == ''
  str = '\'' + str + '\'' unless str=='NULL'
  return str
end


def imageHandler(email) 
  hash = Digest::MD5.hexdigest(email.downcase)
  return "www.gravatar.com/avatar/#{hash}"
end


