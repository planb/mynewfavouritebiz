class RatingController < ApplicationController
  def rate_business
    @business = Business.find(params[:id])
    Rating.delete_all(["rateable_type = 'Business' AND rateable_id = ? AND user_id = ?", @business.id, current_user.id])
    @business.add_rating Rating.new(:rating => params[:rating], :user_id => current_user.id)
  end
  
  def rate_feature
    @feature = Feature.find(params[:id])
    Rating.delete_all(["rateable_type = 'Feature' AND rateable_id = ? AND user_id = ?", @feature.id, current_user.id])
    @feature.add_rating Rating.new(:rating => params[:rating], :user_id => current_user.id)
  end
end
