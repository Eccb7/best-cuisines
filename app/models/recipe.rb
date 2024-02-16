class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods

  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cooking_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true

  scope :public_recipes, -> { where(public: true) }

  def toggle_visibility
    update(public: !public)
  end

  def visible_to?(user)
    public? || (user && user == self.user)
  end
end
