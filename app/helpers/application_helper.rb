module ApplicationHelper
  def current_page_style(controller, action)
    'active' if current_page?(controller: controller, action: action)
  end

  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_class
  end
end
