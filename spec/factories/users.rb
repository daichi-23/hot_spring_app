FactoryBot.define do
  factory :user do
    name {"xxname"}
    sequence :email do |n|
      "xx#{n}@mail.com"
    end
    password {"000000"}
    password_confirmation {"000000"}
    introduction {"xxxxxx"}
  end
end
