FactoryGirl.define do
  factory :user, :class => User do
    name 'John Doe'
    password '!Password1.'
    password_confirmation '!Password1.'
    sequence(:email) { |n| "email#{n}@domain.com" }

    trait :invalid_user do
      sequence(:email) { |n| "email0@domain.com" }
      password ''
    end
  end
end
