require 'rails_helper'

RSpec.describe Feed, :vcr do
  let(:feed) { Feed.new('http://jovemnerd.com.br/categoria/nerdcast/feed/') }

  before { feed.fetch! }

  describe '#podcast' do
    it 'gets podcast info' do
      podcast = feed.podcast
      expect(podcast.name).to eq 'Nerdcast'
      expect(podcast.description).to eq('O mundo pop vira piada no Jovem Nerd')
      expect(podcast.image_url).to match('images/NC_FEED.jpg')
    end
  end

  describe '#episodes' do
    subject { feed.episodes }

    it { expect(subject.size).to eq 482 }

    it 'single episode' do
      single_episode = feed.episodes.first

      expect(single_episode.title).to eq 'Nerdcast 463 – Vingadores: A carência de Ultron'
      expect(single_episode.link).to match('nerdcast-463-vingadores-a-carencia-de-ultron')
      expect(single_episode.description).to match('lambda lambda NERDS!')
      expect(single_episode.summary).to match('lambda lambda NERDS!')
      expect(single_episode.pub_date.day).to eq 1
      expect(single_episode.pub_date.mon).to eq 5
      expect(single_episode.duration).to eq '1:37:15'
      expect(single_episode.audio_url).to match('nerdcast_463_vingadores_2.mp3')
    end
  end
end
