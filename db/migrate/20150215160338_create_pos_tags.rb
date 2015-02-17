class CreatePosTags < ActiveRecord::Migration
  def change
    create_table :pos_tags do |t|
      t.string :tag
      t.string :description

      t.timestamps null: false
    end
  end
end
