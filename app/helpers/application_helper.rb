module ApplicationHelper
  def current_page_style(controller, action)
    'active' if current_page?(controller: controller, action: action)
  end
end
