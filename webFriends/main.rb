
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

puts "development? #{development?}"
puts "production? #{production?}"

def run_sql(sql)
  conn = PG.connect(:dbname => 'friends_db', :host => 'localhost')
  result = conn.exec(sql)
  conn.close
  return result
end


get '/' do
  erb :home
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
  image = sqlStringPrep(image)
  twitter = sqlStringPrep(twitter)
  github = sqlStringPrep(github)
  facebook = sqlStringPrep(facebook)
  website = sqlStringPrep(website)
  email = sqlStringPrep(email)
  phone = sqlStringPrep(phone)

  sql = "INSERT INTO friends (name, age, gender, image, twitter, github, facebook, website, email, phone) VALUES (#{name}, #{age}, #{gender}, #{image}, #{twitter}, #{github}, #{facebook}, #{website}, #{email}, #{phone});"

  run_sql(sql)

  redirect to('/friends')

end


def sqlStringPrep(str)
  str ||= 'NULL'
  str = '\'' + str + '\'' unless str=='NULL'
  return str
end



