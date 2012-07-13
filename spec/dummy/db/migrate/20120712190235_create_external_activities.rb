class CreateExternalActivities < ActiveRecord::Migration
  def change
    create_table :external_activities do |t|
      t.integer :template_id
      t.string :template_type
      t.string :name
      t.integer :user_id
      t.text :url
      t.boolean :append_learner_id_to_url
      t.boolean :popup
      t.string :publication_status

      t.timestamps
    end
  end
end
