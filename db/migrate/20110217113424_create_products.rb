class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :label
      t.string :type
      t.integer :lms_id
      t.string :lms_name
      t.string :lms_url
      t.string :product_ids

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
