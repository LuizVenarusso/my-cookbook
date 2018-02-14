require 'rails_helper'

feature 'user can edit your profile' do
  scenario 'sucessfuly' do
    user = create(:user)

    login_as(user)
    visit root_path

    click_on 'Atualizar Perfil'
    fill_in 'Nome', with: 'Luiz Gustavo'
    fill_in 'Email', with: 'luiz21@email.com'
    fill_in 'Cidade', with: 'SP Capital'
    fill_in 'Facebook', with: 'Facebook.com'
    fill_in 'Twitter', with: 'Twitter.com'
    fill_in 'Senha atual', with: '123456'
    click_on 'Atualizar'

    expect(page).to have_content('Bem vindo: Luiz Gustavo')
    expect(page).to have_content('A sua conta foi atualizada com sucesso.')
  end
  scenario 'and can cancel your account' do
    user = create(:user)

    login_as(user)
    visit edit_user_registration_path

    click_on 'Encerrar minha conta'

    expect(page).to have_content('Início')
    expect(page).to have_content('Entrar')
    expect(page).to have_content('Adeus!')
    expect(page).to have_content('A sua conta foi cancelada com sucesso.')
    expect(page).to have_content('Esperamos vê-lo novamente em breve.')
  end
end
