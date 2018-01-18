require 'rails_helper'

feature 'User favorite recipe' do
  scenario 'successfully' do
    user = User.create(email: 'luiz@email.com', password: '123456' )
    italian_cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    italian_recipe = Recipe.create(title: 'Macarrão Carbonara', recipe_type: recipe_type,
                cuisine: italian_cuisine, difficulty: 'Difícil',
                cook_time: 30, ingredients: 'Massa, ovos, bacon',
                method: 'Frite o bacon; Cozinhe a massa ate ficar al dent; Misture os ovos e o bacon a massa ainda quente;',
                user: user)

    login_as(user)
    visit root_path
    click_on italian_recipe.title
    click_on 'Salvar como Favorita'

    #expect
    expect(page).to have_css('h1', text: italian_recipe.title)
    expect(page).to have_content('Receita favoritada com sucesso')
    expect(page).not_to have_content('Salvar como Favorita')
  end

  scenario 'user unfavorite recipe' do
    user = User.create(email: 'luiz@email.com', password: '123456' )
    italian_cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    italian_recipe = Recipe.create(title: 'Macarrão Carbonara', recipe_type: recipe_type,
                cuisine: italian_cuisine, difficulty: 'Difícil',
                cook_time: 30, ingredients: 'Massa, ovos, bacon',
                method: 'Frite o bacon; Cozinhe a massa ate ficar al dent; Misture os ovos e o bacon a massa ainda quente;',
                user: user)
    Favorite.create(user: user, recipe: italian_recipe)

    login_as(user, scope: :user)
    visit root_path
    click_on italian_recipe.title
    click_on 'Desfavoritar'

    expect(page).to have_css('h1', text: italian_recipe.title)
    expect(page).to have_content('Receita desfavoritada com sucesso')
    expect(page).to have_content('Salvar como Favorita')
    expect(page).not_to have_content('Desfavoritar')
  end

  scenario 'can favorite with other user' do
    user = User.create(email: 'luiz@email.com', password: '123456' )
    user2 = User.create(email: 'teste@email.com', password: '123456' )
    italian_cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    italian_recipe = Recipe.create(title: 'Macarrão Carbonara', recipe_type: recipe_type,
                cuisine: italian_cuisine, difficulty: 'Difícil',
                cook_time: 30, ingredients: 'Massa, ovos, bacon',
                method: 'Frite o bacon; Cozinhe a massa ate ficar al dent; Misture os ovos e o bacon a massa ainda quente;',
                user: user)
    Favorite.create(user: user, recipe: italian_recipe)

    login_as(user2)
    visit root_path
    click_on italian_recipe.title
    click_on 'Salvar como Favorita'
    
    expect(page).to have_css('h1', text: italian_recipe.title)
    expect(page).to have_content('Receita favoritada com sucesso')
    expect(page).not_to have_content('Salvar como Favorita')
  end

end
