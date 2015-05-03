require 'rails_helper'

RSpec.describe Episode, :type => :model do
  it { is_expected.to belong_to :podcast }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :media_url }
  it { is_expected.to validate_presence_of :podcast_id }
  it { is_expected.to validate_presence_of :relase_date }

  it { is_expected.to validate_uniqueness_of :media_url }
end
