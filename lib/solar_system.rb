require_relative 'planets.rb'

class SolarSystem
  attr_reader :star_name, :planets

  def initialize(star_name)
    @star_name = star_name
    @planets = []
  end

  # checking to see if a planet name already exists in the solar system. If it doesn't, we'll push that instance of planet to the planets array
  def add_planet(planet)
      planet_names = @planets.map { |p| p.name.downcase }
      if (planet_names.include?(planet.name.downcase))
        raise ArgumentError.new("This planet already exists in the solar system")
      end
      @planets << planet
  end

  # creates a list of planets by iterating over the @planets array and taking the name and index
  def list_planets
    list = "Planets orbiting #{star_name}: \n"

    @planets.each_with_index do |planet, i|
      list << "#{i+1}. #{planet.name}\n"
    end
    return list
  end

  # uses the planet name to find information about the planet. If the input does not exist in the array, raises an argumenterror
  def find_planet_by_name(lost_planet)
      @planets.each do |planet|
        if planet.name.downcase.include?(lost_planet.downcase)
          return planet
      end
    end
    raise ArgumentError.new("This planet does not exist in the solar system")
  end

  # calculates the distance between two planets
  def distance_between(planet_1_name, planet_2_name)
    planet_1 = find_planet_by_name(planet_1_name)
    planet_2 = find_planet_by_name(planet_2_name)

    return (planet_1.distance_from_sun_km - planet_2.distance_from_sun_km).abs
  end

  # creates a new planet. Any of the error messages in the methods above will apply
  def create_new_planet
    puts "Tell me a little bit about the planet you would like to add.\n What is the planet's name?"
      new_name = gets.chomp.to_s
      puts "What color is this planet?"
      new_color = gets.chomp.to_s
      puts "What is the mass of this planet in kilograms?"
      new_mass = gets.chomp.to_f
      puts "What is this planet's distance from the sun in kilometers?"
      new_distance = gets.chomp.to_f
      puts "What is a fun fact about this planet?"
      new_fact = gets.chomp.to_s

      new_planet = Planet.new(new_name, new_color, new_mass, new_distance, new_fact)
      add_planet(new_planet)
  end
end