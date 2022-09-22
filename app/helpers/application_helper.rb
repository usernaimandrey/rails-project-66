# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def current_title(page_title = '')
    base_title = t('.title')
    page_title.present? ? "#{base_title} | #{page_title}" : base_title
  end

  def render_avatar
    url = current_user&.image_url
    return current_user&.email if url.nil?

    image_tag(url, size: '50x50', alt: current_user&.email, class: 'rounded-circle')
  end
end
