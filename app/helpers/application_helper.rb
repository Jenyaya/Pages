module ApplicationHelper

  def title
    base_title = 'Pages Project'

    if @title.nil?
       base_title
    else
      @title
    end
  end

  def logo
    image_tag("logo.png", :alt => "Pages App", :class => "round")
  end

end
