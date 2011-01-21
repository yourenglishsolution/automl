class CreateSubscribedCourses < ActiveRecord::Migration
  def self.up
    create_table :subscribed_courses do |t|
      t.date :begin_date
      t.date :end_date
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :subscribed_courses
  end
end
