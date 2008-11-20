class Feature < ActiveRecord::Base
  acts_as_rateable
  
  has_permalink :name
  
  def to_param
    permalink
  end
  
end
