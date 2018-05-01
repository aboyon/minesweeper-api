FactoryGirl.define do
  factory :game, :class => Game do
    association :user, :factory => :user
    rows 5
    cols 5
    bombs 1
  end
end
