
# You are the manager at HappiTails animal shelter. You need to do the following:
# Manage the clients coming into the shelter. Track their names, ages, gender, kids and the number of pets they have.
# Manage the animals. Track their names, breed, age, gender and their favorite toys.
# A client will want to come and see the list of available animals to adopt
# A client will want to come in and give up their animal for adoption
# A client will want to list the animals in the shelter
# A client will want to list the clients


require 'rainbow'


class Shelter

  attr_accessor :name, :clients, :adopted_animals, :available_animals

  def initialize(args = {})
    @name = args[:name]
    @clients = args[:clients]
    @adopted_animals = args[:adopted_animals]
    @available_animals = args[:available_animals]

    if @clients == nil
      @clients = []
    end


    if @adopted_animals == nil
      @adopted_animals = []
    end

    if @available_animals == nil
      @available_animals = []
    end

  end


  def displayAnimals
    adoptable = []
    @available_animals.each { |being| adoptable << being.name }
    puts "Adoptable Animals: #{adoptable.join(', ')}".color(:red)
  end

  def displayClients
    clientNames = []
    @clients.each { |being| clientNames << being.name }

    puts "Clients: #{clientNames.join(', ')}".color(:green)
  end



end


class Client

  attr_accessor :name, :age, :gender, :kids, :num_pets, :animals

  def initialize(args = {})
    @name = args[:name]
    @age = args[:age]
    @gender = args[:gender]
    @kids = args[:kids]
    @num_pets = args[:num_pets]
    @animals = args[:animals]

    if @num_pets == nil
      @num_pets = 0
    end

    if @animals == nil
      @animals = []
    end

  end

  def to_s
    unless @num_pets == 0
      "Client: #{@name} has #{@animals}.".color(:yellow)
    else
      "Client: #{@name} has no pets.".color(:yellow)
    end
  end

  def adopt(shelter, animal)

    if num_pets == nil
      @animals = []
    end

    @animals.push(animal)
    shelter.available_animals.delete(animal)
    shelter.adopted_animals.push(animal)

    @num_pets += 1
  end

  def unadopt(shelter, animal)
    @animals.delete(animal)
    shelter.available_animals.delete(animal)
    shelter.available_animals.push(animal)

    @num_pets -= 1
  end

end



class Animal

  attr_accessor :name, :breed, :age, :gender, :favToy, :client

  def initialize(args = {})
    @name = args[:name]
    @breed = args[:breed]
    @gender = args[:gender]
    @favToy = args[:favToy]
    @client = args[:client]
  end

  def to_s
    "#{name} the #{breed}".color(:cyan)
  end

end
