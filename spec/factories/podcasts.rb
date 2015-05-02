FactoryGirl.define do
  factory :podcast do
    name        'Nerdcast'
    description 'Best podcast ever'
    feed_url    'http://some-feed.com/url'
  end
end
