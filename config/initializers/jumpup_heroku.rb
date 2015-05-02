Jumpup::Heroku.configure do |config|
  config.app = 'podaholic'
end if Rails.env.development?
