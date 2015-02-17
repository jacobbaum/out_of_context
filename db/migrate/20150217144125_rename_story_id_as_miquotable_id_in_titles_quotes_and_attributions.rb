class RenameStoryIdAsMiquotableIdInTitlesQuotesAndAttributions < ActiveRecord::Migration
  def change
    rename_column :titles, :story_id, :misquotable_id
    rename_column :quotes, :story_id, :misquotable_id
    rename_column :attributions, :story_id, :misquotable_id
  end
end
