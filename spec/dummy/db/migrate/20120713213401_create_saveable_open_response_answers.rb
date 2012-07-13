class CreateSaveableOpenResponseAnswers < ActiveRecord::Migration
  def change
    create_table :saveable_open_response_answers do |t|
      t.integer :open_response_id
      t.integer :position
      t.text :answer

      t.timestamps
    end
  end
end
