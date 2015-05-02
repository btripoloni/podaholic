require 'rails_helper'

RSpec.describe Podcast, :type => :model do
  it { is_expected.to have_many :episodes }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :feed_url }
end
