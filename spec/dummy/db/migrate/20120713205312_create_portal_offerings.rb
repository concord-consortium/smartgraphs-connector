class CreatePortalOfferings < ActiveRecord::Migration
  def change
    create_table :portal_offerings do |t|
      t.integer :runnable_id
      t.string :runnable_type

      t.timestamps
    end
  end
end
