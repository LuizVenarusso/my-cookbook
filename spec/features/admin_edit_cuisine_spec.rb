require 'rails_helper'

feature 'Admin edit cuisine' do
  scenario 'successfully' do
    user = create(:user, email: 'luiz@email.com', password: '123456')
    user.update_attributes(admin: true)
    cuisine = create(:cuisine, name: 'Americana')

    login_as(user)
    visit root_path

    click_on cuisine.name
    click_on 'Editar'
    fill_in 'Nome', with: 'Italiana'
    save_page
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Italiana')
  end

  scenario 'failed' do
    user = create(:user)
    user.update_attributes(admin: true)
    cuisine = create(:cuisine)

    login_as(user)
    visit root_path

    click_on cuisine.name
    click_on 'Editar'
    fill_in 'Nome', with: ''
    save_page
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'can not edit cuisine without sign-in' do
    user = User.create(email: 'luiz@email.com', password: '123456')
    user.update_attributes(admin: true)
    cuisine = Cuisine.create(name: 'Brasileira')

    visit root_path
    click_on cuisine.name

    expect(page).not_to have_content('Editar')
  end

  scenario 'have not two cuisine with same name' do
    user = create(:user)
    user.update_attributes(admin: true)
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    italian_cuisine = Cuisine.create(name: 'Italiana')

    login_as(user)
    visit root_path

    click_on brazilian_cuisine.name
    click_on 'Editar'
    fill_in 'Nome', with: italian_cuisine.name
    save_page
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
