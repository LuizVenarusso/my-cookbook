class HomeController < ApplicationController
  def index
    @recipes = Recipe.last(6)
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all

    aux_favorite = Favorite.group(:recipe_id).count.sort_by { |_a, b| b }
    @favorite_recipe = aux_favorite.reverse.first(3).to_h
    @favorite = []
    @favorite_recipe.each_entry do |a, _b|
      @favorite << Recipe.find(a)
    end
  end
end
