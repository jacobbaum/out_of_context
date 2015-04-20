class AddSearchTermToMisquote < ActiveRecord::Migration
  def change
    add_column :misquotes, :search_term, :string
  end
end
