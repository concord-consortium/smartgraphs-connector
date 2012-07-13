class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :activity_id
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
