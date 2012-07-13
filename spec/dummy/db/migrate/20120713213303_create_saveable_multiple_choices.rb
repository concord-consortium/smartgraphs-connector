class CreateSaveableMultipleChoices < ActiveRecord::Migration
  def change
    create_table :saveable_multiple_choices do |t|
      t.integer :learner_id
      t.integer :offering_id
      t.integer :multiple_choice_id
      t.integer :response_count, :default => 0

      t.timestamps
    end
  end
end
