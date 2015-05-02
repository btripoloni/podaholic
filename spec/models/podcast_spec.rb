require 'rails_helper'

RSpec.describe Podcast, :type => :model do
  it { is_expected.to have_many :episodes }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :feed_url }

  describe '.import_by_feed_url', :vcr do
    let(:feed_url)   { 'http://jovemnerd.com.br/categoria/nerdcast/feed/' }
    subject(:import) { Podcast.import_by_feed_url(feed_url) }

    it 'imports podcast and episodes' do
      import

      expect(Podcast.count).to eq 1
      expect(Episode.count).to eq 482

      episode = Episode.first

      expect(episode.title).to eq 'Nerdcast 463 – Vingadores: A carência de Ultron'
      expect(episode.show_notes).not_to be_blank
      expect(episode.media_url).not_to be_blank
    end
  end
end
