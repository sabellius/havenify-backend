FactoryBot.define do
  factory :user do
    first_name { 'Israel' }
    last_name { 'Israeli' }
    sequence(:email) { "user#{_1}@example.com" }
    password { 'Password1!' }
  end
end
