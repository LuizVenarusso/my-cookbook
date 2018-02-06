require 'rails_helper'

feature 'Admin edit recipe_type' do
  scenario 'successfully' do
    user = create(:user, email:'luiz@email.com', password: '123456')
    user.update_attribute(:admin, true)
    recipe_type = create(:recipe_type, name: 'Sobremesa')

    login_as(user)
    visit root_path

    click_on 'Sobremesa'
    click_on 'Editar'
    fill_in 'Nome', with: 'Entrada'
    save_page
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Entrada')
end

  scenario 'failed' do
    user = create(:user)
    user.update_attribute(:admin, true)
    recipe_type = create(:recipe_type, name: 'Sobremesa')

    login_as(user)
    visit root_path

    click_on 'Sobremesa'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    save_page
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'can not edit recipe_type without sign-in' do
    user = create(:user)
    user.update_attribute(:admin, true)
    recipe_type = create(:recipe_type, name: 'Sobremesa')

    visit root_path
    click_on recipe_type.name

    expect(page).not_to have_content("Editar")
  end

  scenario 'have not two recipe_type with same name' do
    user = create(:user)
    user.update_attribute(:admin, true)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    main_recipe_type = create(:recipe_type, name: 'Entrada')

    login_as(user)
    visit root_path

    click_on 'Entrada'
    click_on 'Editar'
    fill_in 'Nome', with: 'Sobremesa'
    save_page
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
