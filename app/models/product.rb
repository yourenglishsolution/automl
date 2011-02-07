require 'net/http'

class Product < ActiveRecord::Base
  has_many :subscribes
  has_many :students, :through => :subscribes
  
end


class AtomicProduct < Product
  has_many :instantiated_products
  has_many :students, :through => :instantiated_products
  
  validates_presence_of :lms_url
  validates_uniqueness_of :lms_url
  
  def self.fetch_all
  	fetch
  end
  
  private
  
  # call url api courses docebo
  # http::net
  #def self.fetch(opts = {})
	#connection = Net::HTTP.new("ec2-46-137-4-94.eu-west-1.compute.amazonaws.com")
	# response = ""
	#connection.start do |http|
	 # req = Net::HTTP::Get.new("/api/rest.php?q=/restAPI/auth/getauthmethod")
	 # response = http.request(req)
	# end
	#h = Net::HTTP.new('ec2-46-137-4-94.eu-west-1.compute.amazonaws.com', 80)
	#resp, data = h.get('/api/rest.php?q=/restAPI/auth/getauthmethod', nil )
	
  def self.fetch
	http = Net::HTTP.new("ec2-46-137-4-94.eu-west-1.compute.amazonaws.com")
	request = Net::HTTP::Get.new("/api/rest.php?q=/restAPI/auth/getauthmethod")
	http.request(request)
  end
	
  
end


class CompositeProduct < Product
  serialize :product_ids, Array

  validates_presence_of :product_ids
  
  
  def compositeproducts
    @products ||= Product.find(products_ids)
  end
  
  
end
