FactoryBot.define do
  factory :spot do
    name { "伊予西条駅" }
    address { "愛媛県西条市大町" }
    city { "1" }
    category { "レジャー" }
  end
  trait :invalid_spot do
    category { nil }
  end
  trait :with_icon do
    icon { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.jpg')) }
  end
  trait :with_not_icon do
    icon { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'favicon.ico')) }
  end
end
