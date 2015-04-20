class MisquotesController < ApplicationController
  # before_action :find_id, only: [:update]
  before_action :set_misquote,  only: [:show, :edit, :update, :destroy]
  before_action :show_alterations, only: [:show]
  # before_action :user?, only: [:show, :edit, :update, :destroy]
  # before_action :signed_in_user, except: [:index, :show]
  # before_action :set_user, only: [:edit]
  before_action :correct_user,   except: [:new, :create, :index, :show]

  def index
    @misquotes = Misquote.all
  end

  def show
    @misquote
  end

  def new
  end

  def create
    @misquote = Misquote.create_from_search(params[:query])
    set_user
    if @misquote == 'no matches'
      flash[:failure] = "Apparently, NPR has never interviewed anyone about #{params[:query]}. Please try again?"
    else
      redirect_to edit_misquote_path(@misquote.id)
    end
  end

  def edit
    @misquote
    @sections = @misquote.sections
    @words = @misquote.words
  end

  def update
    word_ids = params.delete_if {|k, v| k =~ /\A\D/ } 
    word_ids.each do |k,v|
      @misquote.words.find(k.to_i).update(replacement: v)
    end
    redirect_to misquote_path(@misquote)
  end

  def destroy
  end

  private

  def show_alterations
    @misquote.make_altered_text
  end

  def set_misquote
    @misquote = Misquote.find(params[:id])
  end

  def set_user
    if signed_in? && @misquote.user.nil?
      @misquote.update_attribute(:user_id, current_user.id)
    end
  end

  def any_user?
    !@misquote.user.nil?
  end

  def correct_user
    unless any_user? && current_user?(@misquote.user)
      redirect_to user_path(current_user)
    end
  end

end