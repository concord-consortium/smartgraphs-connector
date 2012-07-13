class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :section_id
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
