require 'rails_helper'

feature 'User sign in' do

  scenario 'successfully' do

    #cria usuario
    user = User.create(email: 'luiz@email.com', password: '123456' )

    #simula acao usuario

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within("div.actions") do
      click_on 'Entrar'
    end


    #expectativa
    expect(page).to have_content("Bem vindo: #{user.email}")
    expect(page).not_to have_content('Entrar')
    expect(page).to have_content('Sair')
  end

  scenario 'log out' do
    user = User.create(email: 'luiz@email.com', password: '123456' )

    #simula acao usuario
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within("div.actions") do
      click_on 'Entrar'
    end

    click_on 'Sair'

    expect(page).not_to have_content("Bem vindo: #{user.email}")
    expect(page).to have_content('Entrar')
    expect(page).not_to have_content('Sair')

  end

end
