require 'rails_helper'

feature 'Admin register recipe_type' do
  scenario 'successfully' do
    user = create(:user, email: 'luiz@email.com', password: '123456')
    user.update_attributes(admin: true)

    login_as(user)
    visit new_recipe_type_path
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Sobremesa')
    expect(page).to have_content(
      'Nenhuma receita encontrada para este tipo de receitas'
    )
  end

  scenario 'and see buton in nav bar' do
    user = create(:user)
    user.update_attributes(admin: true)

    login_as(user)
    visit root_path

    expect(page).to have_content('Criar novo tipo de receita')
  end

  scenario 'and must fill in name' do
    user = create(:user)
    user.update_attributes(admin: true)

    login_as(user)
    visit new_recipe_type_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and do not repeat' do
    user = create(:user)
    user.update_attributes(admin: true)
    create(:recipe_type, name: 'Arabe')

    login_as(user)

    visit new_recipe_type_path
    fill_in 'Nome', with: 'Arabe'
    click_on 'Enviar'

    expect(RecipeType.count).to eq 1
    expect(page).to have_content('Nome já está em uso')
  end
end
