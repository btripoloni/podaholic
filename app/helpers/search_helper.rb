module SearchHelper

  def show_notes(details, episode_show_notes)
    return episode_show_notes if details[:highlight].blank?
    details[:highlight].fetch(:show_notes, episode_show_notes)
  end
end

