class RenameMisquotesToMisquotables < ActiveRecord::Migration
  def change
    rename_table :misquotes, :misquotables
  end
end
