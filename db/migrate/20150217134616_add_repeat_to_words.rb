class AddRepeatToWords < ActiveRecord::Migration
  def change
    add_column :words, :repeat?, :boolean
  end
end
