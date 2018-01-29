require 'rails_helper'

feature 'Admin edit cuisine' do
  scenario 'successfully' do
    
    user = User.create(email:'luiz@email.com', password: '123456')
    user.update_attribute(:admin, true)
    cuisine = Cuisine.create(name: 'Brasileira')

    # simula a ação do usuário
    login_as(user)
    visit root_path

    click_on 'Brasileira'
    click_on 'Editar'

    fill_in 'Nome', with: 'Italiana'
    save_page
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Italiana')
  end

  scenario 'failed' do

    user = User.create(email:'luiz@email.com', password: '123456')
    user.update_attribute(:admin, true)
    cuisine = Cuisine.create(name: 'Brasileira')

    login_as(user)
    visit root_path

    click_on 'Brasileira'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    save_page
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
 end

 scenario 'can not edit cuisine without sign-in' do

    user = User.create(email:'luiz@email.com', password: '123456')
    user.update_attribute(:admin, true)
    cuisine = Cuisine.create(name: 'Brasileira')
  
    visit root_path
    click_on cuisine.name


     expect(page).not_to have_content("Editar")
 end


end
