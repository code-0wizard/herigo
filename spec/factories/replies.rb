FactoryBot.define do
  factory :reply do
    content { 'MyText' }
    user { nil }
    review { nil }
  end
end
