class ChangeDescriptionToText < ActiveRecord::Migration
  def change
    change_column :cats, :description, :text
  end
end
