module RecipesHelper
  def current_user_owns_recipe?(recipe)
    recipe.user == current_user
  end
end
