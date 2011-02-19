class Subscribe < ActiveRecord::Base
  belongs_to :student
  belongs_to :product
  
end
