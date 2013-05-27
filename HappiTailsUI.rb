





puts "Welcome to Shelter Management"
puts
puts 
puts "What would you like to do?"

resp = gets.chomp

while resp!="q"

  
  case resp

  when "c"
    
    happiTails.displayClients
    
  end


  resp = gets.chomp

end




