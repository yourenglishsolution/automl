class Student < ActiveRecord::Base
  has_many :instantiatedcourses
  has_many :subscribes
  has_many :products, :through => :instantiatedcourses
  has_many :products, :through => :subscribes 
  
end
