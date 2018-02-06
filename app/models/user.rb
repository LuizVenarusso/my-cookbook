class User < ApplicationRecord
  has_many :favorites
  has_many :recipes
  has_many :favorite_recipes, through: :favorites, source: :recipe

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   def is_favorite?(recipe)
     favorite_recipes.include?(recipe)
   end

   def owner_recipe?(recipe)
     recipe.user == self
   end

end
