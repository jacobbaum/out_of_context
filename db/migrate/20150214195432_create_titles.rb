class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.integer :story_id
      t.string :text

      t.timestamps null: false
    end
  end
end
