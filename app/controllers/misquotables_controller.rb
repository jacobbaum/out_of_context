class MisquotablesController < ApplicationController
  before_action :find_id, only: [:alteration, :update]
  before_action :set_misquotable, only: [:show, :edit, :update, :destroy]
  before_action :show_alterations, only: [:show]
  before_action :signed_in_user, except: [:index, :show]
  before_action :correct_user,   except: [:new, :create, :index, :show]

  def index
  end

  def show
    @misquotable
  end

  def new
    @misquotable = Misquotable.new
  end

  def create
    @misquotable = current_user.misquotables.new(misquotable_params)
    @misquotable.npr_create(params[:query_type], params[:query])
    if @misquotable.save 
      redirect_to edit_misquotable_path(@misquotable.id)                # replacements_misquotable_words_path(@misquotable.id)          
    else
      flash[:failure] = "NPR didn't give us any quotes that match your criteria. Want to try again?"
    end
  end

  def edit
    @misquotable
  end

  def alteration
    # @misquotable = Misquotable.find(params[:mq_id])
    word_ids = params.delete_if {|k, v| k =~ /\A\D/ } 
    word_ids.each do |k,v|
      @misquotable.words.find(k.to_i).update(replacement: v)
    end
    redirect_to misquotable_path(@misquotable)
  end

  def update
    # @misquotable = Misquotable.find(params[:mq_id])
    word_ids = params.delete_if {|k, v| k =~ /\A\D/ } 
    word_ids.each do |k,v|
      @misquotable.words.find(k.to_i).update(replacement: v)
    end
    redirect_to misquotable_path(@misquotable)
  end

  def destroy
  end

  def find_id
    @misquotable = Misquotable.find(params[:mq_id])
  end

  def show_alterations
    @misquotable.make_altered_text
  end

  def misquotable_params
    params.require(:misquotable).permit(:topic_id)
  end

  def set_misquotable
    @misquotable = Misquotable.find(params[:id])
  end

  def correct_user
    unless current_user?(@misquotable.user) || current_user.admin?
      redirect_to user_path(current_user)
    end
  end

end
