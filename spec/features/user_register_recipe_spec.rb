require 'rails_helper'

feature 'User register recipe with author' do
  scenario 'successfully' do
    user = create(:user, email: 'luiz@email.com', password: '123456')
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')
    create(:recipe_type, name: 'Prato Principal')
    create(:recipe_type, name: 'Sobremesa')

    login_as(user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_content("Enviado por: #{user.username}")
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir.')
  end

  scenario 'and must fill in all fields' do
    user = create(:user)
    create(:cuisine)
    login_as(user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and can not send recipe without log in' do
    visit root_path
    expect(page).not_to have_content('Enviar uma receita')
  end
end
