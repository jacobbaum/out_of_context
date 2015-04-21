class DropMisquotablesAndTopics < ActiveRecord::Migration
  def change
    drop_table :misquotables
    drop_table :topics
  end
end
