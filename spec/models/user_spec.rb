require 'rails_helper'

RSpec.describe User, type: :model do
  context "is_favorite?" do
    it "user favorite recipe" do
      user = create(:user)
      recipe = create(:recipe, user: user)
      favorite = Favorite.create(user: user , recipe:recipe)

      expect(user.is_favorite?(recipe)).to be_truthy
    end

    it "false" do
      user = create(:user)
      user2 = create(:user, email: '12@email.com')
      recipe = create(:recipe, user: user)
      favorite = Favorite.create(user: user , recipe:recipe)

      expect(user2.is_favorite?(recipe)).to eq false
    end
  end
  context "owner_recipe?" do
    it "owner recipe is current_user?" do
      user = create(:user)
      recipe = create(:recipe, user: user)

      expect(user.owner_recipe?(recipe)).to eq true
    end

    it "false" do
      user = create(:user)
      user2 = create(:user, email:'outro@email.com')
      recipe = create(:recipe, user: user)

      expect(user2.owner_recipe?(recipe)).to eq false
    end
  end
end
