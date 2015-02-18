class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.integer :code

      t.timestamps null: false
    end

    add_column :misquotables, :topic_id, :integer
  end
end
