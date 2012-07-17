class CreateInvestigations < ActiveRecord::Migration
  def change
    create_table :investigations do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end
  end
end
