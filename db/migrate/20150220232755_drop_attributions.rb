class DropAttributions < ActiveRecord::Migration
  def change
    drop_table :attributions
  end
end
