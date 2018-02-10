# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'teste@email.com', password: '123456')
cuisine = Cuisine.create(name: 'Brasileira')
recipe_type = RecipeType.create(name: 'Prato Principal')
recipe = Recipe.create(title: 'Feijoada', recipe_type: recipe_type,
                difficulty: 'Médio',
                cook_time: '50', ingredients: 'Feijão',
                method: 'Cozinhar feijão', cuisine: cuisine,
                user: user)
