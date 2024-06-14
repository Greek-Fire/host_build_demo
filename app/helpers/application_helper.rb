module ApplicationHelper
  def nav_link_to(name, path)
    class_name = 'nav-link'
    class_name += ' active' if current_page?(path)
    
    link_to name, path, class: class_name
  end
end

