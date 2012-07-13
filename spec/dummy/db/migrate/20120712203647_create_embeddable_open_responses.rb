class CreateEmbeddableOpenResponses < ActiveRecord::Migration
  def change
    create_table :embeddable_open_responses do |t|
      t.integer :user_id
      t.string :name
      t.text :prompt

      t.timestamps
    end
  end
end
