class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :text
      t.string :pos_tag_id

      t.timestamps null: false
    end
  end
end
