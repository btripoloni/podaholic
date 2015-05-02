require 'rails_helper'

RSpec.describe Episode, :type => :model do
  it { is_expected.to belong_to :podcast }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :media_url }
  it { is_expected.to validate_presence_of :podcast_id }

  let(:episode) { build(:episode) }

  describe '_resolve_audio_url' do
    context 'when enclosure is an array' do
      subject { episode.send(:resolve_audio_url, [{ url: 'http://ga.com' }]) }
      it { is_expected.to eq 'http://ga.com' }
    end

    context 'when enclosure is a hash' do
      subject { episode.send(:resolve_audio_url, { url: 'http://ga.com' }) }
      it { is_expected.to eq 'http://ga.com' }
    end
  end
end
