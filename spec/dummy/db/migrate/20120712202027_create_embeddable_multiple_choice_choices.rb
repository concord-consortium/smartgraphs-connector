class CreateEmbeddableMultipleChoiceChoices < ActiveRecord::Migration
  def change
    create_table :embeddable_multiple_choice_choices do |t|
      t.integer :multiple_choice_id
      t.text :choice
      t.boolean :is_correct

      t.timestamps
    end
  end
end
