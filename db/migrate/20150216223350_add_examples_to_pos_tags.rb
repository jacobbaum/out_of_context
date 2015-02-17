class AddExamplesToPosTags < ActiveRecord::Migration
  def change
    add_column :pos_tags, :example, :string
  end
end
