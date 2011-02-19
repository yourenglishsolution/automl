require 'net/http'
require 'nokogiri'

class Product < ActiveRecord::Base
  has_many :subscribes
  has_many :students, :through => :subscribes
  
end


class AtomicProduct < Product
  has_many :instantiated_products
  has_many :students, :through => :instantiated_products
  
  validates_presence_of :lms_id, :lms_name, :lms_url 
  validates_uniqueness_of :lms_id, :lms_name, :lms_url
  
  def self.fetch_all
  	connect_to_docebo
  	fetch
  end
    
  private
   
	def self.connect_to_docebo
		@lms = Net::HTTP.new("ec2-46-137-4-94.eu-west-1.compute.amazonaws.com")
	end

  def self.fetch
		request = Net::HTTP::Get.new("/api/rest.php?q=/restAPI/course/courses&auth=yes")
		response = @lms.request(request)
		myDoc = Nokogiri::XML(response.body)
		data = Array.new
		myDoc.root.xpath("//element/course_info").each do |node|
    	data.push({
      	:lms_id => node.xpath("./course_id").text,
	      :lms_name => node.xpath("./course_name").text,
	      :lms_url => node.xpath("./course_link").text
      })
		end
  	data
  end
  
  #def get_token
  	#http = Net::HTTP.new("ec2-46-137-4-94.eu-west-1.compute.amazonaws.com")
  	#request = Net::HTTP::Post.new("/restAPI/auth/authenticate")
	#request.set_form_data({"username" => "admin", "password" => "admin"})
	#response = http.request(request)
  #end
  
end


class CompositeProduct < Product
  serialize :product_ids, Array

  validates_presence_of :product_ids
  
  
  def compositeproducts
    @products ||= Product.find(products_ids)
  end
  
  
end
