class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def favorite?(recipe)
    favorite_recipes.include?(recipe)
  end

  def owner_recipe?(recipe)
    recipe.user == self
  end
end
