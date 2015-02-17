class ChangeReplaceInWordsToReplaceQuestionMark < ActiveRecord::Migration
  def change
    rename_column :words, :replace, :replace?
  end
end
