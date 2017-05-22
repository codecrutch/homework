class RemoveEmailAndName < ActiveRecord::Migration
  def change
    remove_column :users, :name
    remove_column :users, :email

    change_table :users do |t|
      t.string :username, unique: true, null: false
    end
  end
end
