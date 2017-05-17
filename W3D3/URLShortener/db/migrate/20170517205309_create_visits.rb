class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :submitter_id, null: false
      t.integer :shortened_url_id, null: false

      t.index :submitter_id, unique: true 
      t.timestamps null: false
    end
  end
end
