module SearchHelper

  def show_notes(details, episode_show_notes)
    details = Hash(details[:highlight])
    description = details.fetch(:show_notes, episode_show_notes.to_s.truncate(300))
    description.html_safe
  end

  def link_to_publisher(facet, &block)
    link_to search_path(params.merge(podcast_name: facet['term'])), &block
  end
end

