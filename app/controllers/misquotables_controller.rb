class MisquotablesController < ApplicationController
  before_action :set_misquotable, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    # display finished/saved product
  end

  def new
    @misquotable = Misquotable.new
  end

  def create
      @misquotable = Misquotable.new
      @misquotable.npr_create(params[:query_type], params[:query])
    if @misquotable.save 
      redirect_to edit_misquotable_path(@misquotable.id)
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

  def update
    @misquotable.update
  end

  def destroy
  end

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


