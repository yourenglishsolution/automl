class Student < ActiveRecord::Base
  has_many :instantiatedcourses, :subcribes
end
