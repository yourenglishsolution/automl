class InstantiatedCourse < ActiveRecord::Base
  belongs_to :student
  belongs_to :atomicproduct
  
end
