require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao livro de receitas online')
  end

  scenario 'and view recipe' do
    user = create(:user, email: 'luiz@email.com', password: '654321')
    cuisine = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type, name: 'Prato Principal')
    recipe = create(:recipe, title: 'Macarrão', recipe_type: recipe_type,
                             cuisine: cuisine, difficulty: 'Médio',
                             ingredients: 'Macarrão com molho de tomate',
                             method: 'Adicionar a massa na água fervente',
                             cook_time: 60, user: user)

    visit root_path

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine,
                             user: user)

    another_recipe_type = create(:recipe_type, name: 'Prato Principal')
    another_recipe = create(:recipe, title: 'Macarrão',
                                     recipe_type: another_recipe_type,
                                     cuisine: cuisine, difficulty: 'Médio',
                                     ingredients: 'Macarrão e molho de tomate',
                                     method: 'Adicione massa na água fervente',
                                     cook_time: 60, user: user)

    visit root_path

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end
end
