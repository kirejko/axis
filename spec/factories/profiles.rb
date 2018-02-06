# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    user       { User.first || build(:user) }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name  }
  end
end
