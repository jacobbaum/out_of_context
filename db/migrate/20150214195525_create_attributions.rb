class CreateAttributions < ActiveRecord::Migration
  def change
    create_table :attributions do |t|
      t.integer :story_id
      t.string :text

      t.timestamps null: false
    end
  end
end
