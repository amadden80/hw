

def forceAboveZero(value)
  while value <= 0
    print "Must be greater than zero...  Try Again: "
    value = gets.chomp.to_f
  end
  return value
end


def adjustMilesPerGallon(milesPerGallon, speed)

  if (speed - 60) > 0
    milesPerGallon -= (2 * (speed - 60))
  end

  if milesPerGallon < 0
    return 0.0
  else
    return milesPerGallon
  end

end


def getUserInput
  
  print "Input ~ Distance: "
  distance = forceAboveZero(gets.chomp.to_f)

  print "Input ~ Speed: "
  speed = forceAboveZero(gets.chomp.to_f)

  print "Input ~ Cost Per Gallon: "
  costPerGallon = forceAboveZero(gets.chomp.to_f)

  print "Input ~ Miles Per Gallon: "
  milesPerGallon = forceAboveZero(gets.chomp.to_f)

  return distance, speed, costPerGallon, milesPerGallon

end


def printOutput(cost, hours)
  unless cost == Float::INFINITY
    puts "Your trip will take #{hours.round(2)} hrs and cost $#{cost.round(2)}"
  else
    puts "There is not enough money for this trip.  It would cost infinity dollars!"
  end
end


def calcCost(distance, speed, costPerGallon, milesPerGallon)
  milesPerGallon = adjustMilesPerGallon(milesPerGallon, speed)
  (costPerGallon / milesPerGallon) * distance
end


def calcHours(distance, speed)
  distance / speed
end




# Get the user input
distance, speed, costPerGallon, milesPerGallon = getUserInput

# Calcuate cost and hours of the trip
cost = calcCost(distance, speed, costPerGallon, milesPerGallon)
hours = calcHours(distance, speed)

# Pretty Output
printOutput(cost, hours)



