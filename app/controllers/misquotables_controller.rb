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