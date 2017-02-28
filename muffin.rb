# Trent wants to order a raspberry muffin from a cafe
# Trent wants to order a chocolate milkshake from a cafe

# Cafe
# - name
class Cafe
    # A cafe has...
    def initialize(name)
        @name = name
    end

    attr_accessor :name

    def sell_product(person, goods)
      puts "#{@name}: Here is your #{goods}, #{person.name}. Have a nice day!"
    end

end

# Person
# - name
class Person
    # A person has...
    def initialize(name)
        @name = name
    end

    attr_accessor :name

end

# Pretend world that you run and test things in
# We need a cafe
perkup_cafe = Cafe.new('Perkup')
# We need a person
trent = Person.new('Trent')
puts "Hi! what would you like to order"
goods = gets.chomp
# Trent buys a muffin from perkup cafe
#trent.buy_muffin(perkup_cafe)
perkup_cafe.sell_product(trent, goods)
