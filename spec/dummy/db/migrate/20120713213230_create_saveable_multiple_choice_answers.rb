class CreateSaveableMultipleChoiceAnswers < ActiveRecord::Migration
  def change
    create_table :saveable_multiple_choice_answers do |t|
      t.integer :multiple_choice_id
      t.integer :choice_id
      t.integer :position

      t.timestamps
    end
  end
end
