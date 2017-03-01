require 'csv'
require_relative 'recipe'

AVAILABLE_RECIPES_PATH = 'available_recipes.csv'

# Creating a CSV file with recipes
CSV.open(AVAILABLE_RECIPES_PATH, 'w') do |csv|
    csv << Recipe::HEADERS

    recipe = Recipe.new(
        name: 'Curry',
        ingredients: ['1 gallon of curry paste', '500ml of coconut milk', '500g Lamb', '2 cups of rice'],
        serves_count: 4,
        steps: ['Cook meat', 'Cook rice', 'Add coconut milk']
    )
    row = recipe.to_csv_row
    csv << row
end

# Reading a CSV file of recipes
available_recipes = []
CSV.foreach(AVAILABLE_RECIPES_PATH, headers: true) do |row|
    # Convert CSV Row into a Recipe object
    recipe = Recipe.from_csv_row(row)
    available_recipes << recipe
end

# Update recipe

# Delete recipe

puts available_recipes.inspect
Add Comment
