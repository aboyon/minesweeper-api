FactoryGirl.define do
  factory :game, :class => Game do
    association :user, :factory => :user
  end
end
