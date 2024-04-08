FactoryBot.define do
  factory :user do
    first_name { 'Israel' }
    last_name { 'Israeli' }
    sequence(:email) { "user#{_1}@example.com" }
    password { Faker.Internet.password(min_length: 8, mix_case: true, special_characters: true) }
  end
end
