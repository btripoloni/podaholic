FactoryGirl.define do
  factory :episode do
    title         "MyString"
    show_notes    "MyText"
    media_url     "MyString"
    art_work_url  "MyString"
    podcast
    release_date { Time.zone.now }
  end
end
