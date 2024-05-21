FactoryBot.define do
  factory :onsen do
    onsen_name {"xxonsen"}
    onsen_introduction {"xxhotspring"}
    address {"xxcity"}
    latitude {"xxposition"}

    association  :user
  end
end
