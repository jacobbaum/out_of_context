class AddMisquoteIdToWords < ActiveRecord::Migration
  def change
    add_column :words, :misquote_id, :integer
  end
end
