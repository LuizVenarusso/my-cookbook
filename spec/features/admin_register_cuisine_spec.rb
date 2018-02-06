require 'rails_helper'

feature 'Admin register cuisine' do
  scenario 'successfully' do
    user = create(:user, email: 'luiz@email.com', password: '123456')
    user.update_attribute(:admin, true)

    login_as(user)
    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de cozinha')
  end

  scenario 'and see buton in nav bar' do

    user = create(:user)
    user.update_attribute(:admin, true)

    login_as(user)
    visit root_path

    expect(page).to have_content('Criar nova cozinha')
  end

  scenario 'and must fill in name' do

    user = create(:user)
    user.update_attribute(:admin, true)

    login_as(user)

    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'and do not repeat' do
    user = create(:user)
    user.update_attribute(:admin, true)
    create(:cuisine, name: 'Arabe')

    login_as(user)
    visit new_cuisine_path
    fill_in 'Nome', with: 'Arabe'
    click_on 'Enviar'

    expect(Cuisine.count).to eq 1
    expect(page).to have_content('Nome já está em uso')
  end
end
