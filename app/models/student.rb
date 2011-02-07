class Student < ActiveRecord::Base
  has_many :instantiated_courses
  has_many :subscribes
  has_many :products, :through => :instantiated_courses
  has_many :products, :through => :subscribes 
  
end
