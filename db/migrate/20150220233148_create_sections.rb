class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer  "misquotable_id"
      t.string   "type"
      t.text     "text"
      t.text     "altered_text"
      t.string   "type"
      t.timestamps null: false
    end
  end
end
