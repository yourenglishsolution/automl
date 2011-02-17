# ===================================================================================
# BEGIN Product Hierarchy
# -----------------------------------------------------------------------------------

# Abstract class
class Product

  attr_accessor  :name, :delay, :duration, :index, :level
  attr_accessor :d0, :d1

  def initialize(options)
    self.name = options[:name]
    self.level = options[:level]
    self.index = options[:index]
    self.delay = options[:delay]
    self.duration = options[:duration]
  end

  def to_s(i=0)
    "#{name} from #{d0.strftime('%d/%m/%y')} to #{d1.strftime('%d/%m/%y')} (#{duration / 1.minutes} minutes | #{delay / 1.days} days)"
  end

  def indent(i) i.times.collect { '   ' }.join end
  
  def schedule_optimal(options)
    start_day = options[:start_day] || Date.today
    nb_customers = options[:nb_customers] || 1
    level = options[:level]
    puts "-----------------------------------"    
    puts "Scheduling product #{name}, level=#{level}, for #{nb_customers} students, starting at #{start_day.strftime('%d/%m/%Y') }"
    puts "-----------------------------------"
    compute_delay
    compute_time_frame(start_day)
    compute_nb_instances(nb_customers)
    puts to_s
    true
  end

  # returns the next day available
  def compute_time_frame(start_day)
    self.d0 = start_day
    self.d1 = start_day + delay / 1.days
    d1 + 1
  end

end

# Abstract class
class ProductComposite < Product

  attr_accessor :sub_products

  def initialize(options)
    super(options)
    self.sub_products = options[:sub_products] || []
  end

  def adjust_delay(new_delay) 
    self.delay = new_delay
    compute_delay
  end



  # recoursive call...
  def compute_nb_instances(nb_customers)
    sub_products.each { |sp| sp.compute_nb_instances(nb_customers) }
  end

  def compute_delay
    sub_products.each(&:compute_delay)
    self.duration = sub_products.inject(0) { |s, sp| s + sp.duration }
  end

end

class ProductSequence < ProductComposite

  def compute_delay
    super
    computed_delay = sub_products.inject(0) { |s, sp| s + sp.delay }
    self.delay = computed_delay if delay.nil? or delay < computed_delay
    if delay > computed_delay
      sub_products.each { |sp| sp.adjust_delay((sp.delay * delay) / computed_delay) } 
      # we need to adjust the uderlying delay accordingly
    end
  end

  def compute_time_frame(start_day)
    super(start_day)
    t = start_day
    sub_products.each do |sub_product|
      t = sub_product.compute_time_frame(t)
    end
    t
  end

  def to_s(i=0) indent(i) << super(i) << sub_products.collect { |sp| "\n#{sp.to_s(i+1)}" }.join end

end

class ProductParallel < ProductComposite

  def compute_delay
    super
    computed_delay = sub_products.collect(&:delay).max
    self.delay = computed_delay if delay.nil? or delay < computed_delay
    # all sub products get the same dealy as the parralel
    sub_products.each { |sp| sp.adjust_delay(delay) }    
  end

  def compute_time_frame(start_day)
    super(start_day)
    sub_products.each do |sub_product|
      sub_product.compute_time_frame(start_day)
    end
    d1 + 1
  end

  def to_s(i=0) indent(i) << "in parralel #{super}" << sub_products.collect { |sp| "\n#{sp.to_s(i+1)}" }.join end

end

# Abstract class
class ProductAtomic < Product

  attr_accessor :nb_instances, :capacity

  def initialize(options)
    super(options)
    self.capacity = options[:capacity] || (1..1)
    self.nb_instances = nil
  end

  def compute_delay
    raise "error no delay for #{name}" unless delay
    raise "error no duration for #{name}" unless duration

  end

  def adjust_delay(new_delay) self.delay = new_delay end

  def to_s(i=0) indent(i) <<  "#{nb_instances} " << super(i) end

  def compute_nb_instances(nb_customers)
    raise "we neeed at least #{capacity.min} customers for #{name}" if nb_customers < capacity.min
    self.nb_instances = nb_customers / capacity.max
    self.nb_instances += 1 unless nb_customers % capacity.max == 0
  end


end

class ProductDocebo < ProductAtomic

  attr_accessor  :docebo_url

  def initialize(options)
    super(options)
    self.docebo_url = "http://docebo#{options[:docebo_url]}/#{level}/#{index}"
  end

  def to_s(i) super(i) << " #{docebo_url}" end

end

class ProductPlanner < ProductAtomic

  attr_accessor  :reservation, :resource, :duration, :location

  def initialize(options)
    super(options)
    self.reservation = options[:reservation]
    self.resource = options[:resource]
    self.location = options[:location]
  end

  def to_s(i=0)
    s = super(i) << " http://scheduler/#{level}/#{index}"
    s << "\n#{indent(i+1)}should schedule #{duration / 1.minutes} minutes with "
    s << resource.collect { |k, v| "#{v} #{k}(s)" }.join(' & ')
    s << " between #{d0.strftime('%d/%m/%y')} and #{d1.strftime('%d/%m/%y')}"

    if reservation
      s << "\n#{indent(i+1)}reservation open from #{(d0 - reservation[:open]).strftime('%d/%m/%y')}"
      s << " to #{(d0 - (reservation[:close] || 0) - 1).strftime('%d/%m/%y')}"
    end
  end

end

# -----------------------------------------------------------------------------------
# END Product Hierarchy
# ===================================================================================



# ===================================================================================
# BEGIN DSL Interpretor
# -----------------------------------------------------------------------------------

class ProductDsl < Hash

  def initialize(dsl_as_strings)
    super
    instance_eval(dsl_as_strings)
  end

  # create a new product, and add it the the stack
  def product(name, &block)
    options = ProductDslVocabulary.new(name)
    options.instance_eval(&block)
    new_constructor = options.create_constructor
    self[name] = new_constructor
    true
  end

  def build(name, level)
    @hash_name2index ||= {}
    current_index = (@hash_name2index[name] ||= 0)
    @hash_name2index[name] = (current_index += 1)
    klass, options = self[name]
    new_product = klass.new(options.merge(:index => current_index, :level => level))

    # recursion
    new_product.sub_products = new_product.sub_products.collect do |sub_product_name|
      if sub_product_name.is_a?(Array)
        # this a parralel assignement
        ProductParallel.new(:sub_products => sub_product_name.collect { |n| build(n, level) } )
      else
        # this is part of the sequence
        build(sub_product_name, level)
      end

    end if new_product.is_a?(ProductComposite)
    new_product
  end

  def schedule_optimal(name, options={}) build(name, options[:level]).schedule_optimal(options) end

end

# model a product options for the constructor
class ProductDslVocabulary < Hash

  def initialize(name)
    h = super()
    h[:name] = name
  end
  def method_missing(m, *args) self[m] = (args.size == 1 ? args.first : args) end
  def customer_site() "customer_site" end
  def add(product_name) (self[:sub_products] ||= []) << product_name end
  def parallel(*product_names)
    raise "parralel should have at least 2 parameters !" unless product_names.size >= 2
    (self[:sub_products] ||= []) << product_names
  end

  
  def delay(v) self[:delay] = v end

  def resource(h)
    h = { h => 1 } unless h.is_a?(Hash)
    self[:resource] = h
  end
  def create_constructor
    [
    if self[:docebo_url] # this is an atomic DOCEBO product
      ProductDocebo
    elsif self[:resource] # this is requiring resources from the scheduler
      ProductPlanner
    elsif self[:sub_products].size > 1
      ProductSequence
    elsif self[:sub_products].size == 1 and self[:sub_products].first.is_a?(Array)
      ProductParallel
    else
      raise "oups interpreting #{name}"
    end,
    self
    ]
  end

end

# -----------------------------------------------------------------------------------
# END DSL Interpretor
# ===================================================================================

