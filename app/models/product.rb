class Product < ActiveRecord::Base
  has_many :subscribe
  
  def products
    @products ||= Product.find(:all)
  end
  
  
end


class AtomicProduct < Product
  has_many :instantiated_course
  
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
