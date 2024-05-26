FactoryBot.define do
  factory :onsen do
    onsen_name {"xxonsen"}
    onsen_introduction {"xxhotspring"}
    address {"xxcity"}
    latitude {"xxposition"}
    updated_at {Time.current}
    association  :user

    trait :onsen_2 do
      onsen_name {"yyonsen"}
      onsen_introduction {"yyhotspring"}
      address {"yycity"}
      latitude {"yyposition"}
      updated_at {Time.current + 1.days}
      association  :user
    end
  end
end
