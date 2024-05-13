FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "test@example.com" }
    password { "password1" }
    password_confirmation { "password1" }
    activated { true }
  end
end
