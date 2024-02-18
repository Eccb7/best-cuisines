FactoryBot.define do
  factory :recipe do
    name { 'Example Recipe' }
    preparation_time { 30 }
    cooking_time { 45 }
    description { 'A delicious recipe description.' }
    public { true }
    user
  end
end
