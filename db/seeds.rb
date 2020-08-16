require 'open-uri'

puts "Cleaning Database..."
Ingredient.destroy_all if Rails.env.development?
Cocktail.destroy_all if Rails.env.development?

puts "Creating Ingredients..."
url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
ingredients = JSON.parse(open(url).read)
ingredients["drinks"].each do |ingredient|
  i = Ingredient.new(name: ingredient["strIngredient1"])
  puts "Created #{i.name}"
  i.save
end
