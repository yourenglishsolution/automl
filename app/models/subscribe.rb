class Subscribe < ActiveRecord::Base
  belongs_to :student, :product
  
end
