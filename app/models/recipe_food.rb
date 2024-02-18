class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  accepts_nested_attributes_for :food
end
