require 'rails_helper'

feature 'user can register yourself' do
  scenario 'sucessfuly' do
    visit new_user_registration_path

    fill_in 'Nome', with: 'Luiz'
    fill_in 'Email', with: 'luiz@email.com'
    fill_in 'Cidade', with: 'SP'
    fill_in 'Facebook', with: 'Facebook'
    fill_in 'Twitter', with: 'Twitter'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'

    within('div.actions') do
      click_on 'Entrar'
    end

    expect(page).to have_content('Bem vindo: Luiz')
    expect(page).to have_content('Você realizou seu registro com sucesso.')
  end

  scenario 'cant to be blank' do
    visit new_user_registration_path

    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Facebook', with: ''
    fill_in 'Twitter', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar senha', with: ''

    within('div.actions') do
      click_on 'Entrar'
    end

    expect(page).to have_content('Não foi possível salvar usuário: 4 erros.')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
  end
end
