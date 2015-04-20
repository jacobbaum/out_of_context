class AddMisquoteIdToSections < ActiveRecord::Migration
  def change
    add_column :sections, :misquote_id, :integer
    remove_column :words, :misquote_id, :integer
  end
end
