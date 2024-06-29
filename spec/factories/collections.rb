FactoryBot.define do
  factory :collection do
    association  :user
    association  :onsen
    comment {"onsensxxcomment"}
  end
end
