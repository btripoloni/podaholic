module SearchHelper

  def show_notes(details, episode_show_notes)
    description = Hash(details[:highlight]).fetch(:show_notes, episode_show_notes).to_s
    description.truncate(300).html_safe
  end
end

