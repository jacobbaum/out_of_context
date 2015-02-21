class ChangeTypeToName < ActiveRecord::Migration
  def change
    rename_column :sections, :type, :name
  end
end
