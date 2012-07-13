class CreatePageElements < ActiveRecord::Migration
  def change
    create_table :page_elements do |t|
      t.integer :page_id
      t.integer :embeddable_id
      t.string :embeddable_type
      t.integer :position
      t.integer :user_id

      t.timestamps
    end
  end
end
