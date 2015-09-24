module ApplicationHelper
  def nav_link(link_path)
    class_name = params[:action] == link_path[1..-1] ? 'active' : ''

    content_tag(:li, class: class_name) do
      link_to link_path do
        yield 
      end
    end
  end
end
