require 'rails_helper'

feature 'User send recipe photograph' do
	scenario 'succesffuly' do
    user = create(:user)
    create(:cuisine)
    create(:recipe_type, name: 'Prato Principal')

    login_as(user)
    visit root_path

    click_on 'Enviar uma receita'
    fill_in 'Título', with: 'Tabule'
    select 'Brasileira', from: 'Cozinha'
    select 'Prato Principal', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '60'
    fill_in 'Ingredientes', with: 'Farinha, açucar, cenoura'
    fill_in 'Como Preparar', with: 'Cozinhe a cenoura, corte em pedaços pequenos, 
                                    misture com o restante dos ingredientes'
    attach_file('Imagem', 'spec/support/fixtures/feijoada.jpeg')

    click_on 'Enviar'
    
    expect(page).to have_css("img[src*='feijoada.jpeg']")
    expect(page).to have_content("Voltar")
    expect(page).to have_content("Editar")
    expect(page).to have_content("Remover")
    expect(page).to have_content("Salvar como Favorita")

  end


end
