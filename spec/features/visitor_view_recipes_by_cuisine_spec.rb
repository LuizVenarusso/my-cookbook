require 'rails_helper'

feature 'Visitor view recipes by cuisine' do
  scenario 'from home page' do
    user = create(:user, email: "luiz@email.com",password:"123456")
    user.update_attribute(:admin, true)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine, difficulty: 'Médio',
                             cook_time: 60,
                             ingredients: 'Farinha, açucar, cenoura',
                             method: 'Cozinhe a cenoura, corte em pedaços
                             pequenos, misture com o restante dos ingredientes',
                             user:user)

    login_as(user)
    visit root_path
    click_on cuisine.name

    expect(page).to have_css('h1', text: cuisine.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only cuisine recipes' do
    user = create(:user)
    user.update_attribute(:admin, true)
    brazilian_cuisine = create(:cuisine)
    dessert_recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura',
                             recipe_type: dessert_recipe_type,
                             cuisine: brazilian_cuisine, difficulty: 'Médio',
                             cook_time: 60,
                             ingredients: 'Farinha, açucar, cenoura',
                             method: 'Cozinhe a cenoura, corte em pedaços
                                      pequenos, misture com o restante dos
                                      ingredientes', user:user)

    italian_cuisine = create(:cuisine, name: 'Italiana')
    main_recipe_type = create(:recipe_type, name: 'Prato Principal')
    italian_recipe = create(:recipe, title: 'Macarrão Carbonara',
                                     recipe_type: main_recipe_type,
                                     cuisine: italian_cuisine,
                                     difficulty: 'Difícil',
                                     cook_time: 30,
                                     ingredients: 'Massa, ovos, bacon',
                                     method: 'Frite o bacon; Cozinhe a massa;
                                              Misture os ovos e o bacon com a
                                              massa ainda quente;', user:user)
    login_as(user)
    visit root_path
    click_on italian_cuisine.name

    expect(page).to have_css('h1', text: italian_recipe.title)
    expect(page).to have_css('li', text: italian_recipe.recipe_type.name)
    expect(page).to have_css('li', text: italian_recipe.cuisine.name)
    expect(page).to have_css('li', text: italian_recipe.difficulty)
    expect(page).to have_css('li', text: "#{italian_recipe.cook_time} minutos")
  end

  scenario 'and cuisine has no recipe' do
    user = create(:user)
    user.update_attribute(:admin, true)
    brazilian_cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: brazilian_cuisine, difficulty: 'Médio',
                             cook_time: 60,
                             ingredients: 'Farinha, açucar, cenoura',
                             method: 'Cozinhe a cenoura, corte em pedaços
                                      pequenos, misture com o restante dos
                                      ingredientes',
                             user:user)

    italian_cuisine = create(:cuisine, name: 'Italiana')
    login_as(user)
    visit root_path
    click_on italian_cuisine.name

    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de cozinha')
  end
end
