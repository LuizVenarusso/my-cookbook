require 'rails_helper'

RSpec.describe User, type: :model do
  context 'is_favorite?' do
    it 'user favorite recipe' do
      user = create(:user)
      recipe = create(:recipe, user: user)
      create(:favorite, user: user, recipe: recipe)

      expect(user.is_favorite?(recipe)).to be_truthy
    end

    it 'false' do
      first_user = create(:user)
      second_user = create(:user, email: '12@email.com')
      recipe = create(:recipe, user: first_user)
      create(:favorite, user: first_user, recipe: recipe)

      expect(second_user.is_favorite?(recipe)).to eq false
    end
  end
  context 'owner_recipe?' do
    it 'owner recipe is current_user?' do
      user = create(:user)
      recipe = create(:recipe, user: user)

      expect(user.owner_recipe?(recipe)).to eq true
    end

    it 'false' do
      first_user = create(:user)
      second_user = create(:user, email: 'outro@email.com')
      recipe = create(:recipe, user: first_user)

      expect(second_user.owner_recipe?(recipe)).to eq false
    end
  end
end
