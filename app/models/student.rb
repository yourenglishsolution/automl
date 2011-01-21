class Student < ActiveRecord::Base
  has_many :subscribedcourses
end
