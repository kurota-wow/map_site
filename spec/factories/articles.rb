FactoryBot.define do
  factory :article do
    title { "MyString" }
    tag { "MyString" }
    content { "MyText" }
    spot { nil }
  end
end
