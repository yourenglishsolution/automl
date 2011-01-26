class Product < ActiveRecord::Base
  has_many :subscribes
  has_many :students, :through => :subscribes
  
end


class AtomicProduct < Product
  has_many :instantiatedcourses
  has_many :students, :through => :instantiatedcourses
  
  validates_presence_of :lms_url
  validates_uniqueness_of :lms_url
  
end


class CompositeProduct < Product
  serialize :product_ids, Array

  validates_presence_of :product_ids
  
  
  def courses
    @courses ||= Product.find(products_ids)
  end
  
  
end
