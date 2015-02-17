class RenameStoryToMisquote < ActiveRecord::Migration
  def change
    rename_table :stories, :misquotes
  end
end
