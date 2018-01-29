#require 'rails_helper'

#feature 'User send recipe to a friend' do
 # scenario 'succesffuly' do
  #  user = create(:user)
   # recipe = create(:recipe, title: 'Feijoada de Frango', user: user)

    #visit root_path
    #click_on 'Feijoada de Frango'
    #fill_in 'Email', with: 'amigo@email.com'
    #fill_in 'Mensagem', with: 'Essa receita é muito legal'

    #expect(RecipesMailer).to receive(:share).with('amigo@email.com',
     #                                             'Essa receita é muito legal',
      #                                            recipe.id).and_call_original
    #click_on 'Enviar'

    #expect(page).to have_content 'Receita enviada para amigo@email.com'
    #expect(current_path).to eq recipe_path(recipe)
  #end
#end
