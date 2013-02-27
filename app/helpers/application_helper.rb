module ApplicationHelper

  # format the full title
  def full_title(title)
    base_title='Search N\' Find Electronics Reviews'

    if title.empty?
      base_title
    else
      "#{base_title} | #{title}"
    end
  end
end
