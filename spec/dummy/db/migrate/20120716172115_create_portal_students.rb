class CreatePortalStudents < ActiveRecord::Migration
  def change
    create_table :portal_students do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
