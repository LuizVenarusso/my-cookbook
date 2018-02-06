require 'rails_helper'

feature 'Visitor view recipe details' do
  scenario 'successfully' do
    user = create(:user, email: 'luiz@email.com', password: '654321')
    cuisine = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type, name: 'Prato Principal')
    recipe = create(:recipe, title: 'Macarrão', recipe_type: recipe_type,
                             cuisine: cuisine, difficulty: 'Médio',
                             ingredients: 'Macarrão com molho de tomate',
                             method: 'Adicionar a massa na água fervente',
                             cook_time: 60, user:user)

    visit root_path
    click_on recipe.title

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: "#{recipe.cook_time} minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: recipe.ingredients)
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: recipe.method)
  end

  scenario 'and return to recipe list' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine,
                             user: user)

    visit root_path
    click_on recipe.title
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end
end
