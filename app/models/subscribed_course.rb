class SubscribedCourse < ActiveRecord::Base
  belongs_to :student, :atomicproduct
  
end
