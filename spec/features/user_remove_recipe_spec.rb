require 'rails_helper'

feature 'User remove recipe' do
  scenario 'successfully' do
    user = User.create(email:'luiz@email.com', password: '123456')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de Cenoura', recipe_type: recipe_type, difficulty: 'Médio',
      cook_time: '50', ingredients: 'Feijão', method:'Cozinhar feijão', cuisine: cuisine, user:user)

    # simula a ação do usuário
    login_as(user)
    visit root_path
    click_on recipe.title
    click_on 'Remover'

    expect(page).to have_current_path (root_path)
    expect(page).to have_content('Receita removida com sucesso')
    expect(page).not_to have_css('h1', text: recipe.title)
  end

  scenario 'user can not remove recipe without be owner' do
    user = User.create(email:'teste@gmail.com', password: '123456')
    user2 = User.create(email:'luiz@gmail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de Cenoura', recipe_type: recipe_type, difficulty: 'Médio',
      cook_time: '50', ingredients: 'Feijão', method:'Cozinhar feijão', cuisine: cuisine, user:user)

    login_as(user2)
    visit root_path
    click_on recipe.title

    expect(page).not_to have_link("Remover")
  end

  scenario 'User can not see remove link' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    visit recipe_path(recipe)
    
    expect(page).not_to have_link("Remover")
  end

end
