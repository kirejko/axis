# frozen_string_literal: true

FactoryBot.define do
  factory :department do
    name { Faker::ProgrammingLanguage.name + ' Development' }
    description { Faker::ProgrammingLanguage.name + ' Development' }
  end

  factory :invalid_department, parent: :department do
    name 'qwe'
    description 'zxc'
  end
end
