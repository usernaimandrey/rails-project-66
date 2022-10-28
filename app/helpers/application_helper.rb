# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def current_title(page_title = '')
    base_title = t('.title')
    page_title.present? ? "#{base_title} | #{page_title}" : base_title
  end

  def render_avatar
    url = current_user.image_url
    return current_user.email if url.nil?

    image_tag(url, size: '50x50', alt: current_user&.email, class: 'rounded-circle')
  end

  def normalize_file_path(repo, file_path)
    full_name = repo.full_name
    branch = repo.default_branch
    normalize_path = file_path.split(repo.name).last
    "https://github.com/#{full_name}/tree/#{branch}#{normalize_path}"
  end

  def check_status(check)
    return t('.no_check') if check.nil?

    check.passed? ? t('.success') : t('.failure')
  end
end
