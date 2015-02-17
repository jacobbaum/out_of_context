class AddDefaultValueToRepeatInWords < ActiveRecord::Migration
  def change
    change_column :words, :repeat?, :boolean, default: false
  end
end
