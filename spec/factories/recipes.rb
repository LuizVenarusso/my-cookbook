FactoryBot.define do
  factory :recipe do
    title 'Bolo de cenoura'
    recipe_type
    cuisine
    difficulty 'Médio'
    cook_time 60
    ingredients 'Farinha, açucar, cenoura'
    add_attribute(:method) { 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes' }
    user
  end
end
