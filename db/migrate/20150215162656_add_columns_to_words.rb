class AddColumnsToWords < ActiveRecord::Migration
  def change
    add_reference :words, :token, polymorphic: true, index: true
  end
end
