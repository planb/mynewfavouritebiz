class SearchController < ApplicationController
  before_filter :login_required
  
  # This is where all the searches get redirected to.
  def index
    if params[:tag].nil? && params[:location].nil?
      # Both fields are nil, search for all businesses.
      @businesses = Business.paginate :per_page => 10,
                                      :page => params[:page],
                                      :order => 'name'
    elsif params[:tag].nil?
      # Tag field is nil, search by location.
      @businesses = Business.paginate :per_page => 10,
                                      :page => params[:page],
                                      :conditions => ['suburb LIKE ?', "%#{params[:location]}%"],
                                      :order => 'name'
    elsif params[:location].nil?
      # Location field is nil, search by tag.
      @businesses = Business.paginate_by_tag params[:tag],
                                  :order => 'businesses.name DESC',
                                  :page => params[:page],
                                  :per_page => 10
    else
      # Both fields are filled in.
      @businesses = Business.paginate_by_tag params[:tag],
                                  :conditions => ['suburb LIKE ?', "%#{params[:location]}%"],
                                  :order => 'businesses.name DESC',
                                  :page => params[:page],
                                  :per_page => 10
    end
  end
end
