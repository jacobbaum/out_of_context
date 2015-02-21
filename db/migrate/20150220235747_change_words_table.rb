class ChangeWordsTable < ActiveRecord::Migration
  def change
    add_column :words, :section_id, :integer
    remove_column :words, :token_id, :integer
    remove_column :words, :token_type, :string
  end
end
