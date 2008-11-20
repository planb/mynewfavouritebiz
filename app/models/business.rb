class Business < ActiveRecord::Base
  acts_as_rateable
  acts_as_taggable
  
  has_permalink :name
  
  # prevents a user from submitting a crafted form that bypasses activation
  attr_accessible :name, :street, :suburb, :postcode, :phone, :email, :permalink, :checked, :tag_list, :url
  
  def to_param
    permalink
  end
end
