class AddRecipeRefToFavorite < ActiveRecord::Migration[5.1]
  def change
    add_reference :favorites, :recipe, foreign_key: true
  end
end
