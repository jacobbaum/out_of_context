class DropDivsTable < ActiveRecord::Migration
  def change
    drop_table :divs
  end
end
