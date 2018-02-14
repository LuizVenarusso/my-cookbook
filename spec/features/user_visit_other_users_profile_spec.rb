require 'rails_helper'

feature 'user can visit other users profiles' do
  scenario 'and can see informations about this user' do
    first_user = create(:user, username: 'Luiz')
    second_user = create(:user, email: 'outro@email.com', password: '123456',
                                username: 'Gustavo')
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, user: first_user, recipe_type: recipe_type,
                             cuisine: cuisine)

    login_as(second_user)
    visit root_path
    click_on recipe.title
    click_on recipe.user.username

    expect(page).to have_content(first_user.username)
    expect(page).to have_content(first_user.city)
    expect(page).to have_content(first_user.email)
    expect(page).to have_content(recipe.title)
  end
  scenario 'and see on page only recipes from this user' do
    first_user = create(:user, username: 'Luiz')
    second_user = create(:user, email: 'outro@email.com', password: '123456',
                                username: 'Gustavo', city: 'SC')
    recipe_type = create(:recipe_type)
    first_cuisine = create(:cuisine)
    second_cuisine = create(:cuisine, name: 'Mexicana')
    first_recipe = create(:recipe, user: first_user, recipe_type: recipe_type,
                                   cuisine: first_cuisine, title: 'Petisco')
    second_recipe = create(:recipe, user: second_user, recipe_type: recipe_type,
                                    cuisine: second_cuisine, title: 'Bolo')

    login_as(second_user)
    visit root_path
    click_on first_recipe.title
    click_on first_recipe.user.username

    expect(page).to have_content(first_user.username)
    expect(page).to have_content(first_user.city)
    expect(page).to have_content(first_user.email)
    expect(page).to have_content(first_recipe.title)

    expect(page).not_to have_content(second_user.username)
    expect(page).not_to have_content(second_user.city)
    expect(page).not_to have_content(second_user.email)
    expect(page).not_to have_content(second_recipe.title)
  end
end
