class AddReplaceAndReplacementToWords < ActiveRecord::Migration
  def change
    add_column :words, :replace, :boolean
    add_column :words, :replacement, :string
  end
end
