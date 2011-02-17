require "product_dsl"

pdsl = ProductDsl.new("

# =======================================================================
# Atomic products
# -----------------------------------------------------------------------

product  'Need Analysis'  do
  duration  30.minutes
  delay 1.days
  docebo_url  '/cours/888'
end

product  'Written Tests'  do
  duration  1.hours
  delay 2.days
  docebo_url  '/cours/12'
end

product  'iTest'  do
  duration  30.minutes
  delay 3.days
  docebo_url  '/cours/234'
end

product  'Phone Audit'  do
  delay 1.weeks
  duration  15.minutes
  resource 'professeur'
  reservation :open => 4.days, :close => 1.days
end

product  'Intro Session'  do
  duration  2.hours
  delay 1.weeks
  location  customer_site
  resource  'representant'
  capacity  10..20
  reservation :open => 1.weeks, :close => 1.weeks
end

product  'Face to Face'  do
  duration  1.5.hours
  delay  1.weeks
  resource  'professeur'
  capacity  3..5
  reservation :open => 1.weeks, :close => 1.days
  location  'Paris'
end

product  'micro learning'  do
  duration  3.minutes
  delay 1.days
  docebo_url  '/microlearning'
end

# =======================================================================
# LSAT example
# -----------------------------------------------------------------------

product  'LSAT'  do
  delay  2.weeks # not mandatory, (could be computed from sub products)
  add 'Need Analysis'
  parallel 'iTest', 'Written Tests' # in parallel
  add 'Phone Audit'
end

# =======================================================================
# LSAT + Intro session example (doesn't work !)
# -----------------------------------------------------------------------

product  'LSAT and Intro Session'  do
  delay  1.months
  add   'LSAT'
  add   'Intro Session'
end

# =======================================================================
# LSAT with Face2Face  in Paris 
# -----------------------------------------------------------------------

product  'LSAT luxe'  do
  add 'Need Analysis'
  parallel 'iTest', 'Written Tests' # in parallel
  add 'Face to Face'
end

# =======================================================================
# Blended Face to Face - Intense
# -----------------------------------------------------------------------

product 'micro learning 1 week' do
  5.times do
    add 'micro learning'
  end
end


product 'Blended Face to Face - Intense' do
  3.times do
    add 'micro learning 1 week'
    parallel 'Face to Face', 'micro learning 1 week'
  end
end

")

puts "==================================="
puts "#{pdsl.size} products loaded:"
puts pdsl.collect(&:first).join(", ")
puts "==================================="

# testing...
pdsl.schedule_optimal("LSAT", :start_day => Date.today, :nb_customers => 1)
pdsl.schedule_optimal("LSAT and Intro Session", :nb_customers => 20)
pdsl.schedule_optimal("LSAT luxe", :start_day => Date.today, :nb_customers => 10)
pdsl.schedule_optimal("Blended Face to Face - Intense", :level => "A1", :start_day => Date.today, :nb_customers => 3)


true