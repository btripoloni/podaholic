class Feed
  attr_accessor :url
  attr_reader   :response

  def initialize(url)
    @url = url
  end

  def fetch!
    response = HTTParty.get(url)
    raise response.body unless response.success?
    @response = Nokogiri.parse(response.body)
  end

  def podcast
    OpenStruct.new(
      :name         => content_at('title'),
      :description  => content_at('description'),
      :image_url    => resolve_image_url(content_at('image')))
  end

  def episodes
    response.xpath('//item').inject([]) do |arr, item|
      arr << OpenStruct.new(
        :title            => item.css('title').text,
        :link             => item.css('link').text,
        :description      => item.css('description').text,
        :summary          => item.css('itunes|summary').text,
        :pub_date         => Time.zone.parse(item.css('pubDate').text),
        :duration         => item.css('itunes|duration').text,
        :audio_url        => resolve_audio_url(item.css('enclosure').to_s),
        :image_url        => item.css('image').text.try(:url)
      )
    end
  end

  private

  def resolve_audio_url(enclosure)
    extract_url(enclosure)
  end

  def resolve_image_url(image_node)
    extract_url(image_node)
  end

  def extract_url(text)
    text.match(/(#{URI.regexp})/)
    $1
  end

  def content_at(xpath)
    @response.at_xpath("//rss/channel//#{xpath}").content
  end
end
