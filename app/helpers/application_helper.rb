module ApplicationHelper

  def title
    base_title = 'Page'

    if @title.nil?
       base_title
    else
      "#{@title} #{base_title}"
    end
  end

  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end

end
