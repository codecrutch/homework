class RenameCatsDescription < ActiveRecord::Migration
  def change
    rename_column :cats, :decription, :description
  end
end
