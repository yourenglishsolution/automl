class CreateInstantiatedCourses < ActiveRecord::Migration
  def self.up
    create_table :instantiated_courses do |t|
      t.date :begin_date
      t.date :end_date
      t.string :status
      t.integer :student_id
      t.integer :atomicproduct_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :instantiated_courses
  end
end
