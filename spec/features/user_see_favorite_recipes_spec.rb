require 'rails_helper'

feature 'user can see three most favorite recipes in home page ' do
  scenario 'sucessfuly' do
    first_user = create(:user, email: 'email1@email.com')
    second_user = create(:user, email: 'email2@email.com')
    third_user = create(:user, email: 'email3@email.com')
    fourth_user = create(:user, email: 'email4@email.com')
    fifth_user = create(:user, email: 'email5@email.com')

    first_cuisine = create(:cuisine)
    second_cuisine = create(:cuisine, name: 'Italiana')
    third_cuisine = create(:cuisine, name: 'Portuguesa')
    fourth_cuisine = create(:cuisine, name: 'Mexicana')
    fifth_cuisine = create(:cuisine, name: 'Japonesa')

    first_recipe_type = create(:recipe_type)
    second_recipe_type = create(:recipe_type, name: 'Prato Principal')
    third_recipe_type = create(:recipe_type, name: 'Sobremesa')
    fourth_recipe_type = create(:recipe_type, name: 'Acompanhamento')
    fifth_recipe_type = create(:recipe_type, name: 'Petisco')

    first_recipe = create(:recipe, recipe_type: first_recipe_type,
                                   cuisine: first_cuisine, user: first_user)
    second_recipe = create(:recipe, title: 'bolo',
                                    recipe_type: second_recipe_type,
                                    cuisine: second_cuisine, user: second_user)
    third_recipe = create(:recipe, title: 'cenoura',
                                   recipe_type: third_recipe_type,
                                   cuisine: third_cuisine, user: third_user)
    fourth_recipe = create(:recipe, title: 'ameixa',
                                    recipe_type: fourth_recipe_type,
                                    cuisine: fourth_cuisine, user: fourth_user)
    fifth_recipe = create(:recipe, title: 'amora',
                                   recipe_type: fifth_recipe_type,
                                   cuisine: fifth_cuisine, user: fifth_user)

    Favorite.create(user: first_user, recipe: first_recipe)
    Favorite.create(user: second_user, recipe: first_recipe)
    Favorite.create(user: third_user, recipe: first_recipe)
    Favorite.create(user: fourth_user, recipe: first_recipe)
    Favorite.create(user: fifth_user, recipe: first_recipe)

    Favorite.create(user: first_user, recipe: second_recipe)
    Favorite.create(user: second_user, recipe: second_recipe)
    Favorite.create(user: third_user, recipe: second_recipe)
    Favorite.create(user: fourth_user, recipe: second_recipe)
    Favorite.create(user: fifth_user, recipe: second_recipe)

    Favorite.create(user: first_user, recipe: third_recipe)
    Favorite.create(user: second_user, recipe: third_recipe)
    Favorite.create(user: third_user, recipe: third_recipe)
    Favorite.create(user: fourth_user, recipe: third_recipe)
    Favorite.create(user: fifth_user, recipe: third_recipe)

    Favorite.create(user: first_user, recipe: first_recipe)
    Favorite.create(user: second_user, recipe: second_recipe)
    Favorite.create(user: third_user, recipe: third_recipe)
    Favorite.create(user: fourth_user, recipe: fourth_recipe)
    Favorite.create(user: fifth_user, recipe: fifth_recipe)

    visit root_path

    expect(page).to have_css('div.favoritas', text: first_recipe.title)
    expect(page).to have_css('div.favoritas', text: second_recipe.title)
    expect(page).to have_css('div.favoritas', text: third_recipe.title)

    expect(page).not_to have_css('div.favoritas', text: fourth_recipe.title)
    expect(page).not_to have_css('div.favoritas', text: fifth_recipe.title)
  end
end
