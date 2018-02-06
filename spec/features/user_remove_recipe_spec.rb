require 'rails_helper'

feature 'User remove recipe' do
  scenario 'successfully' do
    user = create(:user, email: 'luiz@email.com', password: '654321')
    cuisine = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type, name: 'Prato Principal')
    recipe = create(:recipe, title: 'Macarrão', recipe_type: recipe_type,
                             cuisine: cuisine, difficulty: 'Médio',
                             ingredients: 'Macarrão com molho de tomate',
                             method: 'Adicionar a massa na água fervente',
                             cook_time: 60, user: user)
    login_as(user)
    visit root_path
    click_on recipe.title
    click_on 'Remover'

    expect(page).to have_current_path root_path
    expect(page).to have_content('Receita removida com sucesso')
    expect(page).not_to have_css('h1', text: recipe.title)
  end

  scenario 'user can not remove recipe without be owner' do
    first_user = create(:user)
    second_user = create(:user, email: 'luiz@gmail.com', password: '123456')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    cuisine = create(:cuisine, name: 'Italiana')
    recipe = create(:recipe, title: 'Macarrão', recipe_type: recipe_type,
                             cuisine: cuisine, difficulty: 'Médio',
                             ingredients: 'Macarrão com molho de tomate',
                             method: 'Adicionar a massa na água fervente',
                             cook_time: 60, user: first_user)
    login_as(second_user)
    visit root_path
    click_on recipe.title

    expect(page).not_to have_link('Remover')
  end

  scenario 'User can not see remove link' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    visit recipe_path(recipe)

    expect(page).not_to have_link('Remover')
  end
end
