# frozen_string_literal: true

class Guest
  def id; end

  def created_at; end

  def name; end

  def email; end

  def token; end

  def image_url; end

  def nickname; end

  def repositories
    []
  end

  def links_list
    []
  end

  def guest?
    true
  end
end
