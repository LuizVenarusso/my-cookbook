require 'rails_helper'

RSpec.describe RecipesMailer do
  describe 'share' do
    it 'should send the correct email' do
      user = create(:user)
      recipe = create(:recipe, user: user)

      mail = RecipesMailer.share('luiz@email.com', 'teste', recipe.id)

      expect(mail.to).to include 'luiz@email.com'
      expect(mail.subject).to eq 'Compartilharam uma receita com você'
      expect(mail.from).to include 'no-reply@cookbook.com'
      expect(mail.body).to include 'teste'
      expect(mail.body).to include recipe_url(recipe)
    end
  end
end
