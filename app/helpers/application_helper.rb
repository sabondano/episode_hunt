module ApplicationHelper
  def nav_link(link_path)
    class_name = params[:action].gsub(/[_]/, '-') == link_path[1..-1] ? 'active' : ''

    content_tag(:li, class: class_name) do
      link_to link_path do
        yield 
      end
    end
  end

  def cache_key_for(model)
    prefix         = model.to_s.downcase.pluralize
    count          = model.count
    max_updated_at = model.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{prefix}/all-#{count}-#{max_updated_at}"
  end

end
