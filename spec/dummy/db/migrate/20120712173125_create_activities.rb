class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :publication_status
      t.integer :user_id
      t.integer :investigation_id
      t.timestamps
    end
  end
end
