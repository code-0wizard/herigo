FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { 'test@example.com' }
    password { 'password1' }
    password_confirmation { 'password1' }
    activated { true }
  end

  factory :inactive_user do
    name { 'Test User' }
    email { 'not_activated@example.com' }
    password { 'password1' }
    password_confirmation { 'password1' }
    activated { false }
  end
end
