class Feed
  attr_accessor :url
  attr_reader   :response

  def initialize(url)
    @url = url
  end

  def fetch!
    response = HTTParty.get(url)
    raise response.body unless response.success?
    @response = response['rss']['channel']
  end

  def podcast
    OpenStruct.new(name: response['title'],
                   description: response['description'],
                   image_url: response['image'][1]['href'])
  end

  def episodes
    response['item'].inject([]) do |arr, item|
      arr << OpenStruct.new(
              title: item['title'],
              link: item['link'],
              description: item['description'],
              summary: item['summary'],
              raw_description: item['encoded'],
              pub_date: Date.parse(item['pubDate']),
              duration: item['duration'],
              audio_url: item['enclosure']['url'],
              image: item['image'].try(:url)
            )
    end
  end
end
