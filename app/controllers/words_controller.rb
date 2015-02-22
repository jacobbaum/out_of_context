class WordsController < ApplicationController
  before_action :set_word, only: [:edit, :update]
  # before_action :set_words, only: [:replacements]

  def index
    
  end

  def edit
    @word
  end

  def update
    @word.update(word_params)
    head :updated, location: word_path(@word)
  end

  # def set_words
  #   @word = Word.find(params[:misquotable_id])
  # end

  def set_word
    @word = Word.find(params[:id])
  end

  def replacements
    @words = Misquotable.find(params[:misquotable_id]).words
  end

  def replace
    @words = Word.update(params[:replacements])
  end

  def word_params
    params.require(:word).permit(:replacement)
  end

end

# [56, 57, 58]
# def edit_individual
#   @products = Product.find(params[:product_ids])
# end

# def update_individual
#   @products = Product.update(params[:products].keys, params[:products].values).reject { |p| p.errors.empty? }
#   if @products.empty?
#     flash[:notice] = "Products updated"
#     redirect_to products_url
#   else
#     render :action => "edit_individual"
#   end
# end

Product.where(id: params[:product_ids]).update_all(discontinued: true)






# replacements_misquotable_words POST   /misquotables/:misquotable_id/words/replacements(.:format)               words#replacements
#      replace_misquotable_words PUT    /misquotables/:misquotable_id/words/replace(.:format)                    words#replace

