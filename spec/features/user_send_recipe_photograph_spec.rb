require 'rails_helper'

feature 'User send recipe photograph' do
	scenario 'succesffuly' do

    user = User.create(email:'luiz@email.com', password: '123456')
    Cuisine.create(name: 'Arabe')
	RecipeType.create(name: 'Entrada')
	Recipe.create(title: 'BolodeCenoura', recipe_type: recipe_type, difficulty: 'Médio',
      			 	cook_time: '50', ingredients: 'Feijão', method:'Cozinhar feijão',
       				cuisine: cuisine, user:user)

    login_as(user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Fotografia', with: ''
    click_on 'Enviar'
    #expect(page).to have_content('')

	end  
end
