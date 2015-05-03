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

      podcast = Podcast.first

      expect(podcast.name).to eq 'Nerdcast'
      expect(podcast.description).to match 'mundo pop'
      expect(podcast.image_url).not_to be_blank

      episode = Episode.first

      expect(episode.title).to eq 'Nerdcast 463 – Vingadores: A carência de Ultron'
      expect(episode.show_notes).not_to be_blank
      expect(episode.media_url).not_to be_blank
    end
  end

  describe '.import_by_apple_podcast_id', :vcr do
    subject(:import) { Podcast.import_by_apple_podcast_id(601457993) }

    it 'imports podcast and episodes' do
      import

      expect(Podcast.count).to eq 1
      expect(Episode.count).to eq 99

      podcast = Podcast.first

      expect(podcast.name).to eq 'The NerdCast: A Nerdery Podcast'
      expect(podcast.description).to match 'NerdCasts share relevant information'
      expect(podcast.image_url).not_to be_blank

      episode = Episode.first

      expect(episode.title).to match 'Overnight Web Challenge Founder'
      expect(episode.show_notes).to match 'you’ll learn something from this podcast'
    end
  end
end
