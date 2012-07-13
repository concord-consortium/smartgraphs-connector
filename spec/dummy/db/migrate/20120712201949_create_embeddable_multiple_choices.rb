class CreateEmbeddableMultipleChoices < ActiveRecord::Migration
  def change
    create_table :embeddable_multiple_choices do |t|
      t.string :name
      t.text :prompt
      t.integer :user_id

      t.timestamps
    end
  end
end
