FactoryGirl.define do
  factory :earthquake do
    sequence(:id, 250_000) { |n| "ak#{n}" }
    location { "#{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    magnitude { "#{rand(1..7)}.#{rand(0..99)}".to_f }
    distance { magnitude * 100 - rand(1..(magnitude * 100)) * rand }
    occurred_on { created_at }
    created_at { Faker::Time.between(30.days.ago, 1.day.ago) }
    updated_at { created_at + rand(0..5).minutes + rand(0..59).seconds }

    trait :epoch do
      created_at { Time.at(0) }
    end

    trait :today do
      created_at { 10.minutes.ago }
    end

    trait :yesterday do
      created_at { 1.day.ago }
    end

    trait :not_felt do
      distance { magnitude * 200 }
    end
  end
end
