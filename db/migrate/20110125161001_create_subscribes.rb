class CreateSubscribes < ActiveRecord::Migration
  def self.up
    create_table :subscribes do |t|
      t.integer :nb_months

      t.timestamps
    end
  end

  def self.down
    drop_table :subscribes
  end
end
