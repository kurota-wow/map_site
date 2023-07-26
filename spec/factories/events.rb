FactoryBot.define do
  factory :event do
    name { "sample" }
    season { "夏" }
  end
  trait :invalid do
    season { nil }
  end
  trait :with_image do
    image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.jpg')) }
  end
  trait :with_not_image do
    image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'favicon.ico')) }
  end
end
