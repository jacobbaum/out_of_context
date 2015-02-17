class ChangeReplaceColumnInWords < ActiveRecord::Migration
  def change
    change_column :words, :replace, :boolean, default: false
  end
end
