# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email     { Faker::Internet.safe_email }
    password  { 'password' }

    after :build do |user|
      create :profile, user: user
    end
  end
end
