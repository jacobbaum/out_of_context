class MisquotablesController < ApplicationController
  before_action :set_misquotable, only: [ :show, :edit, :update, :destroy]

  def index
  end

  def show
    @misquotable
  end

  def new
    @misquotable = Misquotable.new
  end

  def create
    @misquotable = Misquotable.create(misquotable_params)
    @misquotable.npr_create(params[:query_type], params[:query])
    if @misquotable.save 
      redirect_to edit_misquotable_path(@misquotable.id)                # replacements_misquotable_words_path(@misquotable.id)          
    else
      #TODO flash documentation?
      flash[:failure] = "NPR didn't give us any quotes\
                      \ that match your criteria. Want to try again?"
      render 'new'
    end
  end

  def edit
    @misquotable
  end

  def alteration
    @misquotable = Misquotable.find(params[:mq_id])
    word_ids = params.delete_if {|k, v| k =~ /\A\D/ } 
    word_ids.each do |k,v|
      @misquotable.words.find(k.to_i).update(replacement: v)
    end
    @misquotable.make_altered_text.save

    redirect_to misquotable_path(@misquotable)
  end

  def update
    @misquotable.update
  end

  def destroy
  end

  def misquotable_params
    params.require(:misquotable).permit(:topic_id)
  end

  # def replace_word_params
  #   params=(:section_ids)
  # end

  # def misquotable_params
  #   params.require(:misquotable).permit(:title, :quote, :attribution, :link)
  # end

  # def misquotable_params
  #     params.require(:misquotable).permit(:name, :rating, :price,
  #                                  :description, :image_file)
  #   end

  def set_misquotable
    @misquotable = Misquotable.find(params[:id])
  end

end

# {"utf8"=>"✓",
#  "_method"=>"patch",
#  "authenticity_token"=>"Rizh0iAUYvmovz6OSOmpI6x0cf9bhozXo0NtV26fxkAuQsTrVlBnnJ7qSY8nWn/uOnOZeZpsQiI9Uve8XDShSQ==",
#  "misquotable"=>{"title_attributes"=>{"word"=>{"replacement"=>"drinks",
#  "id"=>""},
#  "id"=>"40"},
#  "quote_attributes"=>{"word"=>{"replacement"=>"pizza",
#  "id"=>""},
#  "id"=>"39"}},
#  "commit"=>"Submit",
#  "id"=>"34"}



# {"utf8"=>"✓",
#  "_method"=>"patch",
#  "authenticity_token"=>"wAN900JogMoGBjNcytvSQP5Y5t/C7P/ULvM7iIp5RtaobVjqNCyFrzBTRF2laASNaF8OWQMGMSGw4qFjuNIh3w==",
#  "misquotable"=>
      # {"title_attributes"=>
      #   {"word"=>
      #     {"replacement"=>"runs"}, 
      #   "id"=>"40"},
      #   "quote_attributes"=>
      #     {"word"=>
      #       {"replacement"=>"banana"},
      #     "id"=>"39"}
      #   },
      # "commit"=>"Submit",
      # "id"=>"34"}

      # quote nested under title?

# word_ids = params.delete_if {|k, v| k =~ /\A\D/ } 
# word_ids.each do |k,v|
#   @misquotable.words.find(k.to_i).update(replacement: v)
# end

#   mql.words.find(1619).update(replacement: "good)
# end


# @misquotable.words.find




# if k == word.id

# word.replacement = v


# {"utf8"=>"✓",
#  "_method"=>"put",
#  "authenticity_token"=>"0BW//G6K6naM71YIjc7l80i2ZBQWPszVMXuUr1yYGNC4e5rFGM7vE7q6IQnifTM+3rGMktfUAiCvag5EbjN/2Q==",
#  "1570"=>"jumps",
#  "1581"=>"guns",
#  "1608"=>"chicanos",
#  "1619"=>"poorly",
#  "commit"=>"Submit",
#  "id"=>":id"}

