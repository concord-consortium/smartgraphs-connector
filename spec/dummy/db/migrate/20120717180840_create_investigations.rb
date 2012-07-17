class CreateInvestigations < ActiveRecord::Migration
  def change
    create_table :investigations do |t|
      t.string :name
      t.string :publication_status
      t.integer :user_id
      t.timestamps
    end
  end
end
