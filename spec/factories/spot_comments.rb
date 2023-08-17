FactoryBot.define do
  factory :spot_comment do
    content { "MyText" }
    customer { nil }
    spot { nil }
  end
end
