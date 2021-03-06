require 'rails_helper'

feature 'Visitor register recipe' do
  scenario 'successfully' do
    user = create(:user, email: 'luiz@email.com', password: '123456')
    recipe = create(:recipe, user: user)
    italian_cuisine = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type, name: 'Prato Principal')
    italian_recipe = create(:recipe, title: 'Macarrão Carbonara',
                                     recipe_type: recipe_type,
                                     cuisine: italian_cuisine,
                                     difficulty: 'Difícil',
                                     cook_time: 30,
                                     ingredients: 'Massa, ovos, bacon',
                                     method: 'Frite o bacon; Cozinhe a massa;
                                              Misture os ovos e o bacon com a
                                              massa ainda quente;',
                                     user: user)
    visit root_path
    fill_in 'Buscar', with: recipe.title
    click_on 'Buscar'

    expect(page).to have_content("Resultados da busca por: #{recipe.title}")
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_content(recipe.recipe_type.name)
    expect(page).to have_content(recipe.cuisine.name)
    expect(page).to have_content(recipe.difficulty)
    expect(page).to have_content(recipe.cook_time)
    expect(page).to have_content(recipe.ingredients)
    expect(page).to have_content(recipe.method)

    expect(page).not_to have_css('h1', text: italian_recipe.title)
    expect(page).not_to have_content(italian_recipe.recipe_type.name)
    expect(page).not_to have_content(italian_recipe.cuisine.name)
    expect(page).not_to have_content(italian_recipe.difficulty)
    expect(page).not_to have_content(italian_recipe.cook_time)
    expect(page).not_to have_content(italian_recipe.ingredients)
    expect(page).not_to have_content(italian_recipe.method)
  end

  scenario 'find title and ingredients' do
    user = create(:user)
    italian_cuisine = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type, name: 'Prato Principal')
    recipe_one = create(:recipe, title: 'Macarrão Carbonara',
                                 recipe_type: recipe_type,
                                 cuisine: italian_cuisine,
                                 difficulty: 'Difícil',
                                 cook_time: 30,
                                 ingredients: 'Massa, ovos, bacon',
                                 method: 'Frite o bacon; Cozinhe a massa;
                                          Misture os ovos e o bacon com a
                                          massa ainda quente;',
                                 user: user)

    recipe_two = create(:recipe, title: 'Pizza', recipe_type: recipe_type,
                                 cuisine: italian_cuisine, difficulty: 'Fácil',
                                 cook_time: 30,
                                 ingredients: 'Carbonara, queijo,calabresa',
                                 method: 'Coloque a pizza no forno.',
                                 user: user)

    recipe_three = create(:recipe, title: 'Feijoada', recipe_type: recipe_type,
                                   cuisine: italian_cuisine,
                                   difficulty: 'Fácil', cook_time: 30,
                                   ingredients: 'Feijao,calabresa',
                                   method: 'Coloque a Feijoada no fogao.',
                                   user: user)

    nome_busca = 'Carbonara'
    visit root_path
    fill_in 'Buscar', with: nome_busca
    click_on 'Buscar'

    expect(page).to have_content("Resultados da busca por: #{nome_busca}")
    expect(page).to have_css('h1', text: recipe_one.title)
    expect(page).to have_content(recipe_one.recipe_type.name)
    expect(page).to have_content(recipe_one.cuisine.name)
    expect(page).to have_content(recipe_one.difficulty)
    expect(page).to have_content(recipe_one.cook_time)
    expect(page).to have_content(recipe_one.ingredients)
    expect(page).to have_content(recipe_one.method)

    expect(page).to have_css('h1', text: recipe_two.title)
    expect(page).to have_content(recipe_two.recipe_type.name)
    expect(page).to have_content(recipe_two.cuisine.name)
    expect(page).to have_content(recipe_two.difficulty)
    expect(page).to have_content(recipe_two.cook_time)
    expect(page).to have_content(recipe_two.ingredients)
    expect(page).to have_content(recipe_two.method)

    expect(page).not_to have_css('h1', text: recipe_three.title)
    expect(page).not_to have_content(recipe_three.ingredients)
  end

  scenario 'and dont find any' do
    user = create(:user)
    italian_cuisine = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type, name: 'Prato Principal')
    italian_recipe = create(:recipe, title: 'Macarrão Carbonara',
                                     recipe_type: recipe_type,
                                     cuisine: italian_cuisine,
                                     difficulty: 'Difícil',
                                     cook_time: 30,
                                     ingredients: 'Massa, ovos, bacon',
                                     method: 'Frite o bacon; Cozinhe a massa;
                                              Misture os ovos e o bacon com a
                                              massa ainda quente;',
                                     user: user)
    nome_busca = 'Frango'
    visit root_path
    fill_in 'Buscar', with: nome_busca
    click_on 'Buscar'

    expect(page).to have_content("Resultados da busca por: #{nome_busca}")
    expect(page).to have_content('Nenhuma receita encontrada')
    expect(page).not_to have_css('h1', text: italian_recipe.title)
    expect(page).not_to have_content(italian_recipe.recipe_type.name)
    expect(page).not_to have_content(italian_recipe.cuisine.name)
    expect(page).not_to have_content(italian_recipe.difficulty)
    expect(page).not_to have_content(italian_recipe.cook_time)
    expect(page).not_to have_content(italian_recipe.ingredients)
    expect(page).not_to have_content(italian_recipe.method)
  end
end
