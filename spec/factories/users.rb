# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { 'password' }
    role { User::ROLES[:user] }

    after :build do |user|
      create :profile, user: user
    end
  end

  factory :admin, class: User do
    email { Faker::Internet.safe_email }
    password { 'password' }
    role { User::ROLES[:admin] }

    after :build do |user|
      create :profile, user: user
    end
  end
end
