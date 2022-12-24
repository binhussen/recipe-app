require 'rails_helper'

RSpec.describe 'Recipes', type: :system, js: true do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Rex', email: 'rex@mail.com', password: '123456')
      sign_in @user

      @recipe = Recipe.create(user: @user, name: 'Apple Pie', preparation_time: 2, cooking_time: 1,
                              description: 'Nice food wow', public: true)
      visit recipes_path
    end

    it 'renders name of recipe' do
      expect(page).to have_content(@recipe.name)
    end

    it 'renders description of the recipe' do
      expect(page).to have_content(@recipe.description[0...100])
    end

    it 'renders remove button' do
      expect(page).to have_content('Remove')
    end

    it 'redirects to delete path' do
      click_button 'Remove'
      expect(page).to have_current_path(recipes_path)
    end

    it 'renders a button to add recipe' do
      expect(page).to have_content('Add Recipe')
    end

    it 'redirects to a form for new recipe' do
      click_link 'Add Recipe'
      expect(page).to have_current_path(new_recipe_path)
    end
  end

  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'Rex', email: 'rex@mail.com', password: '123456')
      sign_in @user

      @recipe = Recipe.create(user: @user, name: 'Apple Pie', preparation_time: 2, cooking_time: 1,
                              description: 'Nice food wow', public: true)
      visit recipe_path(@recipe)
    end

    it 'renders name of recipe' do
      expect(page).to have_content(@recipe.name)
    end

    it 'renders description of the recipe' do
      expect(page).to have_content(@recipe.description)
    end

    it 'renders preparation time' do
      expect(page).to have_content(@recipe.preparation_time)
    end

    it 'renders cooking time' do
      expect(page).to have_content(@recipe.cooking_time)
    end

    it 'renders public status' do
      expect(page).to have_content(@recipe.public?.to_s.capitalize)
    end

    it 'renders add ingredient button' do
      expect(page).to have_content('Add Ingredient')
    end

    it 'redirects to add ingredient page' do
      click_link 'Add Ingredient'
      expect(page).to have_current_path(new_recipe_recipe_food_path(@recipe))
    end

    it 'renders shopping list button' do
      expect(page).to have_content('Generate Shopping List')
    end

    it 'redirects to general shopping list' do
      click_link 'Generate Shopping List'
      expect(page).to have_current_path(general_shopping_list_path)
    end
  end
end
