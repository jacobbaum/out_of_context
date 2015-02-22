class AddUserIdToMisquotables < ActiveRecord::Migration
  def change
    add_column :misquotables, :user_id, :integer
  end
end
