class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :user
  belongs_to :recipe_type
  has_many :favorites
  validates :title, :recipe_type, :difficulty, :cook_time, presence: true
  has_attached_file :image, styles: { medium: "300x300>", thumb: "120x90#" }
  validates_attachment :image,
  content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
