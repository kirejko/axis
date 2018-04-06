FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    body { Faker::Lorem.paragraphs.join("\n") }
  end

  factory :invalid_article, parent: :article do
    title 'zx'
    body 'qwe'
  end
end
