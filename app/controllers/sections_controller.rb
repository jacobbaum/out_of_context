class SectionsController < ApplicationController

  def replacements
    @sections = Misquotable.find(params[:misquotable_id]).sections
  end

end