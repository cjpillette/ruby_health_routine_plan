require 'csv'

## Recipe
# - name (essential)
# - ingredients (essential)
# - serves_count (essential)
# - steps (essential?)

class Recipe
  attr_accessor :name, :ingredients, :serves_count, :steps

  # def initialize(name, ingredients, serves_count, steps)
  #   @name = name
  #   @ingredients = ingredients
  #   @serves_count = serves_count
  #   @steps = steps
  # end

  def initialize(hash)
    @name = hash[:name]
    @ingredients = hash[:ingredients]
    @serves_count = hash[:serves_count]
    @steps = hash[:steps]
  end

  HEADERS = ['name', 'ingredients', 'serves_count', 'steps']

  def to_csv_row
    [
      @name,
      @ingredients.join('|'),
      @serves_count,
      @steps.join('|')
    ]
  end

  def Recipe.from_csv_row(row)
    name = row['name']
    ingredients = row['ingredients']
    serves_count = row['serves_count']
    steps = row['steps']

    return Recipe.new(
        name: name,
        ingredients: ingredients.split('|'),
        serves_count: serves_count.to_i,
        steps: steps.split('|')
    )
  end
end
