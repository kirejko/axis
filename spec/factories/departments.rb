# frozen_string_literal: true

FactoryBot.define do
  factory :department do
    name Faker::ProgrammingLanguage.name + ' Development'
  end
end
