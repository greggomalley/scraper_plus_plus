module ApplicationHelper
  def custom_time_format(date_time, null_text = nil)
    return null_text if date_time.nil?

    if Time.now - date_time < 1.day
      time_ago_in_words(date_time) + " ago"
    else
      l(date_time, format: :long)
    end
  end
end
