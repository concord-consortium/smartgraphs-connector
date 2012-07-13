class CreatePortalLearners < ActiveRecord::Migration
  def change
    create_table :portal_learners do |t|
      t.integer :offering_id

      t.timestamps
    end
  end
end
