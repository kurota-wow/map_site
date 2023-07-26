module ApplicationHelper
  BASE_TITLE = "ぐるぐるマップ愛媛".freeze

  def full_title(page_title)
    page_title.present? ? "#{page_title} - #{BASE_TITLE}" : BASE_TITLE
  end
end