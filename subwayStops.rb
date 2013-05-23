
# User interaction
def menu(subwayNetwork)

  lineOptions = subwayNetwork.keys.map { |key, val| key.to_s }

  puts "Valid Lines are: #{lineOptions}"
  print "What line are you getting on at?: " 
  resp = gets.chomp
  onLine = validate(resp, lineOptions)

  puts "Stations on that line: #{subwayNetwork[onLine.to_sym][:stops]}"
  print "What station are you getting on at?: "
  resp = gets.chomp
  onStation = validate(resp, subwayNetwork[onLine.to_sym][:stops])

  puts "Valid Lines are: #{lineOptions}"
  print "What line are you getting off at?: "
  resp = gets.chomp
  offLine = validate(resp, lineOptions)

  puts "Stations on that line: #{subwayNetwork[offLine.to_sym][:stops]}"
  print "What station are you getting off at?: "
  resp = gets.chomp
  offStation = validate(resp, subwayNetwork[offLine.to_sym][:stops])

  return onLine, onStation, offLine, offStation

end

def validate(resp, options)
  until options.include? resp do
    puts " Valide options include #{options}."  
    print "Selection valid option: "
    resp = gets.chomp
  end
  return resp
end



# Count the number of stops 
def countStops(onLine, onStation, offLine, offStation, subwayNetwork, unionStation)
  if onLine == offLine
    numStops = ( subwayNetwork[onLine.to_sym][:stops].index(onStation) - subwayNetwork[offLine.to_sym][:stops].index(offStation) ).abs
  else
    numStops = ( subwayNetwork[onLine.to_sym][:stops].index(onStation) - subwayNetwork[onLine.to_sym][:stops].index(unionStation) ).abs
    numStops +=   (subwayNetwork[offLine.to_sym][:stops].index(unionStation) - subwayNetwork[offLine.to_sym][:stops].index(offStation) ).abs
  end
  return numStops
end


# Define Subway Network
N_Line = {:name => "N", :stops => ['Times Square', '34th', '28th', '23rd', 'Union Square', '8th'], :working? => true}
L_Line = {:name => "L", :stops => ['8th', '6th', 'Union Square', '3rd', '1st'], :working? => true}
Six_Line = {:name => "6", :stops => ['Grand Central', '33rd', '28th', '23rd', 'Union Square', 'Astor Place'], :working? => true}
subwayNetwork = {:N => N_Line, :L => L_Line, :Six => Six_Line}
unionStation = 'Union Square'

# Run Session
onLine, onStation, offLine, offStation = menu(subwayNetwork)
numStops = countStops(onLine, onStation, offLine, offStation, subwayNetwork, unionStation)
puts "Your trip will be #{numStops} stops."






# C_Line = {:name => "C", :stops => ['CW', 'ATerm', 'Union Square', 'Wash'], :working? => true}
# D_Line = {:name => "D", :stops => ['32nd', 'CenPark', 'Union Square', '6th'], :working? => true}
