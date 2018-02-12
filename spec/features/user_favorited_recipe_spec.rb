require 'rails_helper'

feature 'User favorite recipe' do
  scenario 'successfully' do
    user = create(:user, email: 'luiz@email.com', password: '123456')
    italian_cuisine = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type, name: 'Prato Principal')
    italian_recipe = create(:recipe, title: 'Macarrão Carbonara',
                                     recipe_type: recipe_type,
                                     cuisine: italian_cuisine,
                                     difficulty: 'Difícil',
                                     cook_time: 30,
                                     ingredients: 'Massa, ovos, bacon',
                                     method: 'Frite o bacon; Cozinhe a massa
                                              ate ficar al dent; Misture os ovos
                                              e o bacon a massa ainda quente;',
                                     user: user)

    login_as(user)
    visit root_path
    click_on italian_recipe.title
    click_on 'Salvar como Favorita'

    expect(page).to have_css('h1', text: italian_recipe.title)
    expect(page).to have_content('Receita favoritada com sucesso')
    expect(page).not_to have_content('Salvar como Favorita')
  end

  scenario 'user unfavorite recipe' do
    user = create(:user)
    italian_cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    italian_recipe = create(:recipe, recipe_type: recipe_type,
                                     cuisine: italian_cuisine, user: user)
    create(:favorite, user: user, recipe: italian_recipe)

    login_as(user)
    visit root_path
    first('.favoritas').click_on italian_recipe.title
    click_on 'Desfavoritar'

    expect(page).to have_css('h1', text: italian_recipe.title)
    expect(page).to have_content('Receita desfavoritada com sucesso')
    expect(page).to have_content('Salvar como Favorita')
    expect(page).not_to have_content('Desfavoritar')
  end

  scenario 'can favorite with other user' do
    first_user = create(:user)
    second_user = create(:user, email: 'luiz@gmail.com', password: '123456')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    cuisine = create(:cuisine, name: 'Italiana')
    recipe = create(:recipe, title: 'Macarrão', recipe_type: recipe_type,
                             cuisine: cuisine, difficulty: 'Médio',
                             ingredients: 'Macarrão com molho de tomate',
                             method: 'Adicionar a massa na água fervente',
                             cook_time: 60, user: first_user)
    Favorite.create(user: first_user, recipe: recipe)

    login_as(second_user)
    visit root_path
    first('.favoritas').click_on recipe.title
    click_on 'Salvar como Favorita'

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_content('Receita favoritada com sucesso')
    expect(page).not_to have_content('Salvar como Favorita')
  end
end
