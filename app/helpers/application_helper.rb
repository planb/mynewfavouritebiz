# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(page_title)
    content_for(:title) { "MyNewFavourite.biz :: " + page_title }
  end
  
  def body(body_js)
    content_for(:body) { " " + body_js }
  end
  
  def admin?
    logged_in? && current_user.admin?
  end
end
