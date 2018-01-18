require 'rails_helper'

feature 'Visitor register recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    #cuisine = create(:cuisine)
    #brazilian_recipe = create(title: 'Bolo de cenoura', recipe_type: 'Sobremesa',
    #                      cuisine: cuisine, difficulty: 'Médio',
    #                      cook_time: 60,
    #                      ingredients: 'Farinha, açucar, cenoura',
    #                      method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    user = User.create(email: 'luiz@email.com', password: '123456' )
    brazilian_recipe = create(:recipe, user:user)
    italian_cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    italian_recipe = Recipe.create(title: 'Macarrão Carbonara', recipe_type: recipe_type,
                                                        cuisine: italian_cuisine, difficulty: 'Difícil',
                                                        cook_time: 30, ingredients: 'Massa, ovos, bacon',
                                                        method: 'Frite o bacon; Cozinhe a massa ate ficar al dent; Misture os ovos e o bacon a massa ainda quente;',
                                                      user: user)
    # simula a ação do usuário
    visit root_path
    fill_in 'Buscar', with: brazilian_recipe.title
    click_on 'Buscar'

    #expectativa
    expect(page).to have_content("Resultados da busca por: #{brazilian_recipe.title}")
    expect(page).to have_css('h1', text: brazilian_recipe.title)
    expect(page).to have_content(brazilian_recipe.recipe_type.name)
    expect(page).to have_content(brazilian_recipe.cuisine.name)
    expect(page).to have_content(brazilian_recipe.difficulty)
    expect(page).to have_content(brazilian_recipe.cook_time)
    expect(page).to have_content(brazilian_recipe.ingredients)
    expect(page).to have_content(brazilian_recipe.method)

    expect(page).not_to have_css('h1', text: italian_recipe.title)
    expect(page).not_to have_content(italian_recipe.recipe_type.name)
    expect(page).not_to have_content(italian_recipe.cuisine.name)
    expect(page).not_to have_content(italian_recipe.difficulty)
    expect(page).not_to have_content(italian_recipe.cook_time)
    expect(page).not_to have_content(italian_recipe.ingredients)
    expect(page).not_to have_content(italian_recipe.method)
  end

  scenario 'find title and ingredients' do

    #cria os dados necessários.
    user = User.create(email: 'luiz@email.com', password: '123456' )
    italian_cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    recipe_one = Recipe.create(title: 'Macarrão Carbonara', recipe_type: recipe_type,
                                                        cuisine: italian_cuisine, difficulty: 'Difícil',
                                                        cook_time: 30, ingredients: 'Massa, ovos, bacon',
                                                        method: 'Frite o bacon; Cozinhe a massa ate ficar al dent; Misture os ovos e o bacon a massa ainda quente;',
                                                      user:user)

    recipe_two = Recipe.create(title: 'Pizza', recipe_type: recipe_type,
      cuisine: italian_cuisine, difficulty: 'Fácil',cook_time: 30,
       ingredients: 'Carbonara, queijo,calabresa',
       method: 'Coloque a pizza no forno.',user:user)

       recipe_three = Recipe.create(title: 'Feijoada', recipe_type: recipe_type,
         cuisine: italian_cuisine, difficulty: 'Fácil',cook_time: 30,
          ingredients: 'Feijao,calabresa',
          method: 'Coloque a Feijoada no fogao.',user:user)

    #Simula a ação do usuario
    nome_busca = 'Carbonara'
    visit root_path
    fill_in 'Buscar', with: nome_busca
    click_on 'Buscar'

    #expectativa
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
    #cria os dados necessários.
    user = User.create(email: 'luiz@email.com', password: '123456' )
    italian_cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    italian_recipe = Recipe.create(title: 'Macarrão Carbonara', recipe_type: recipe_type,
        cuisine: italian_cuisine, difficulty: 'Difícil',
        cook_time: 30, ingredients: 'Massa, ovos, bacon',
        method: 'Frite o Frango; Cozinhe a massa ate ficar al dent; Misture os ovos e o bacon a massa ainda quente;', user:user)

    #Simula a ação do usuario
    nome_busca = 'Frango'
    visit root_path
    fill_in 'Buscar', with: nome_busca
    click_on 'Buscar'

    #expect
    expect(page).to have_content("Resultados da busca por: #{nome_busca}")
    expect(page).to have_content("Nenhuma receita encontrada")
    expect(page).not_to have_css('h1', text: italian_recipe.title)
    expect(page).not_to have_content(italian_recipe.recipe_type.name)
    expect(page).not_to have_content(italian_recipe.cuisine.name)
    expect(page).not_to have_content(italian_recipe.difficulty)
    expect(page).not_to have_content(italian_recipe.cook_time)
    expect(page).not_to have_content(italian_recipe.ingredients)
    expect(page).not_to have_content(italian_recipe.method)
  end

end
