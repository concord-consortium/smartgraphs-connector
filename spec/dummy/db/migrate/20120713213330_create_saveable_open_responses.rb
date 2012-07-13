class CreateSaveableOpenResponses < ActiveRecord::Migration
  def change
    create_table :saveable_open_responses do |t|
      t.integer :learner_id
      t.integer :offering_id
      t.integer :open_response_id
      t.integer :response_count, :default => 0

      t.timestamps
    end
  end
end
