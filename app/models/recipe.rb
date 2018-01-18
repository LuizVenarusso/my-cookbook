class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :user
  belongs_to :recipe_type
  has_many :favorites
  validates :title, :recipe_type, :difficulty, :cook_time, presence: true
end
