class CreateInstantiatedProducts < ActiveRecord::Migration
  def self.up
    create_table :instantiated_products do |t|
      t.date :begin_date
      t.date :end_date
      t.string :status
      t.integer :student_id
      t.integer :atomic_product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :instantiated_products
  end
end
