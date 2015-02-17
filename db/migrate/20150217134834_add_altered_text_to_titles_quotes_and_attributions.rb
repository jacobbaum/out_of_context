class AddAlteredTextToTitlesQuotesAndAttributions < ActiveRecord::Migration
  def change
    add_column :titles, :altered_text, :string
    add_column :quotes, :altered_text, :string
    add_column :attributions, :altered_text, :string
  end
end
