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

  factory :admin, parent: :user do
    role { User::ROLES[:admin] }
  end

  factory :top_manager, parent: :user do
    role { User::ROLES[%i[director recruiter].sample] }
  end
end
