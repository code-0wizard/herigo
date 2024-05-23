module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Herigo"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def formatted_post_time(created_at)
    time_difference = Time.current - created_at

    if time_difference < 1.hour
      "#{(time_difference / 1.minute).to_i}分前"
    elsif time_difference < 24.hours
      "#{(time_difference / 1.hour).to_i}時間前"
    else
      created_at.strftime("%Y/%m/%d %H:%M")
    end
  end 
end
