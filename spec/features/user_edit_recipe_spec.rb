require 'rails_helper'

feature 'User edit recipe' do
  scenario 'successfully' do
    user = create(:user, email: 'luiz@email.com', password: '123456')
    cuisine = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    create(:recipe, title: 'BolodeCenoura', recipe_type: recipe_type,
                    difficulty: 'Médio',
                    cook_time: '50', ingredients: 'Feijão',
                    method: 'Cozinhar feijão', cuisine: cuisine,
                    user: user)

    login_as(user)
    visit root_path
    click_on 'BolodeCenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de Cenoura'
    fill_in 'Ingredientes', with: 'Cenoura, oléo, farinha de trigo'
    fill_in 'Como Preparar', with: 'Misturar tudo.'
    save_page
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de Cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Italiana')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '50 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Cenoura, oléo, farinha de trigo')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo.')
  end

  scenario 'failed' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    create(:recipe, title: 'BolodeCenoura', recipe_type: recipe_type,
                    difficulty: 'Médio',
                    cook_time: '50', ingredients: 'Feijão',
                    method: 'Cozinhar feijão', cuisine: cuisine,
                    user: user)

    login_as(user)
    visit root_path
    click_on 'BolodeCenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'user do not edit recipe without sign-in' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, recipe_type: recipe_type,
                             cuisine: cuisine,
                             user: user)

    visit root_path
    click_on recipe.title

    expect(page).not_to have_content('Editar')
  end

  scenario 'user only edit your recipes' do
    first_user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, title: 'BolodeCenoura', recipe_type: recipe_type,
                             difficulty: 'Médio',
                             cook_time: '50', ingredients: 'Feijão',
                             method: 'Cozinhar feijão', cuisine: cuisine,
                             user: first_user)

    second_user = create(:user, email: 'luiz@gmail.com', password: '123456')

    login_as(second_user)
    visit root_path
    click_on recipe.title

    expect(page).not_to have_link('Editar')
  end

  scenario 'redirect to index if user is not owner' do
    first_user = create(:user)
    second_user = create(:user, email: 'luiz@gmail.com', password: '123456')
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, title: 'BolodeCenoura', recipe_type: recipe_type,
                             difficulty: 'Médio',
                             cook_time: '50', ingredients: 'Feijão',
                             method: 'Cozinhar feijão', cuisine: cuisine,
                             user: first_user)

    login_as(second_user)
    visit edit_recipe_path recipe

    expect(page).to have_current_path root_path
    expect(page).to have_content('Sem permissão para editar esta receita')
  end
end
