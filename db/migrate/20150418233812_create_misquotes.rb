class CreateMisquotes < ActiveRecord::Migration
  def change
    create_table :misquotes do |t|
      t.integer :npr_id
      t.string :link
      t.string :title
      t.string :question
      t.string :answer
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
