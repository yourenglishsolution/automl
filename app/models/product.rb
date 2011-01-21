class Product < ActiveRecord::Base
  
end


class AtomicProduct < Product
  has_many :subscribedcourses
  
  validates_presence_of :lms_url
  validates_uniqueness_of :lms_url
  
end


class CompositeProduct < Product
  serialize :product_ids

  validates_presence_of :product_ids
  
  
end
