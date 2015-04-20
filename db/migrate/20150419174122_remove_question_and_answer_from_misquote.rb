class RemoveQuestionAndAnswerFromMisquote < ActiveRecord::Migration
  def change
    remove_column :misquotes, :question, :string
    remove_column :misquotes, :answer, :string
  end
end
