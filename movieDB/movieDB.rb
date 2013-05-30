# require 'pry'
require 'pg'
require 'HTTParty'
require 'JSON'
require 'rainbow'

conn = PG.connect(:dbname => 'moviedb', :host => 'localhost')

print "(p)rint  (q)uit  or Enter Movie Title: "
movieTitle = gets.chomp.split(' ').join('+')

while movieTitle != 'q'

  if movieTitle == 'p'
    rows = conn.exec("SELECT * FROM movies")
    rows.each do |row|
      puts "#{row['title']} (#{row['year']})".color(:green)
    end

  else

    requestStr = "http://www.omdbapi.com/?t=" + movieTitle
    response = HTTParty.get(requestStr)
    jsone_response = JSON(response)


    if jsone_response['Response'] == 'True'

      sql_command = "SELECT title FROM movies WHERE title='#{jsone_response['Title']}'"
    
      unless (conn.exec(sql_command).count > 0)

        title, year, rated, genre, released, runtime, director, writer, actors, imdbRating = nil

        title  ||= jsone_response['Title']
        year  ||= jsone_response['Year']
        rated ||= jsone_response['Rated']
        genre ||= jsone_response['Genre']
        released ||= jsone_response['Released']
        runtime ||= jsone_response['Runtime']
        director ||= jsone_response['Director']
        writer ||= jsone_response['Writer']
        actors ||= jsone_response['Actors']
        imdbRating ||= jsone_response['imdbRating'] 

        imdbRating = 'NULL' if imdbRating == 'N/A'


        sql_command = "INSERT INTO movies (title, year, rated, genre, released, runtime, director, writer, actors, imdbRating) VALUES ('#{title}', #{year}, '#{rated}', '#{genre}', '#{released}', '#{runtime}', '#{director}', '#{writer}', '#{actors}', #{imdbRating});"
        conn.exec(sql_command)

        puts "#{title} (#{year})".color(:blue)

      else
        puts "already in database...".color(:red)
      end

    else
      puts "moive not found...".color(:red)
    end

  end

  print "(p)rint  (q)uit  or Enter Movie Title: "
  movieTitle = gets.chomp.split(' ').join('+')
end
