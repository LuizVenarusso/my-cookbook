
require 'rails_helper'

feature 'Visitor view recipes by type' do
  scenario 'from home page' do
    user = create(:user, email: 'luiz@email.com', password: '123456')
    user.update_attributes(admin: true)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine, difficulty: 'Médio',
                             cook_time: 60,
                             ingredients: 'Farinha, açucar, cenoura',
                             method: 'Cozinhe a cenoura, corte em pedaços
                             pequenos, misture com o restante dos ingredientes',
                             user: user)

    login_as(user)
    visit root_path
    click_on recipe_type.name

    expect(page).to have_css('h1', text: recipe_type.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only recipes from same type' do
    user = create(:user)
    user.update_attributes(admin: true)
    brazilian_cuisine = create(:cuisine)
    dessert_recipe_type = create(:recipe_type)
    dessert_recipe = create(:recipe, recipe_type: dessert_recipe_type,
                                     cuisine: brazilian_cuisine, user: user)

    italian_cuisine = create(:cuisine, name: 'Italiana')
    main_recipe_type = create(:recipe_type, name: 'Prato Principal')
    main_recipe = create(:recipe, recipe_type: main_recipe_type,
                                  cuisine: italian_cuisine, user: user)

    login_as(user)
    visit root_path
    click_on main_recipe_type.name

    expect(page).to have_css('li', text: main_recipe.recipe_type.name)
    expect(page).to have_css('li', text: main_recipe.cuisine.name)
    expect(page).not_to have_css('li', text: dessert_recipe.recipe_type.name)
    expect(page).not_to have_css('li', text: dessert_recipe.cuisine.name)
  end

  scenario 'and type has no recipe' do
    user = create(:user)
    user.update_attributes(admin: true)
    brazilian_cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, recipe_type: recipe_type,
                             cuisine: brazilian_cuisine, user: user)

    main_dish_type = create(:recipe_type, name: 'Prato Principal')

    login_as(user)
    visit root_path
    click_on main_dish_type.name

    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este
                                  tipo de receitas')
  end
end
