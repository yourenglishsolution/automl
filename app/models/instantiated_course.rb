class InstantiatedCourse < ActiveRecord::Base
  belongs_to :student, :atomicproduct
  
end
