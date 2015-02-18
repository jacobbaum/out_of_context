class MisquotablesController < ApplicationController

def index
end

def show
  # display finished/saved product
end

def new
  # doesn't apply to npr quotes. Not Starting with an empty container 
  # this will get used if/when user ability to create their own misquotables is implemented
  # or, is this the default view?
end

#done when user selects a topic and clicks submit
def create
  #get rid of start number as argument/move it into method?
  NprApi.get_json(params[:topic_code], 1) 
  @misquote = Misquotable.create_from_npr_api(NprApi.get_quotes_from_json).first
  #four lines for creating and processing words. move? condense?
  @misquote.create_words
  @misquote.quote.flag_words(flag_tags)  
  @misquote.title.flag_words(flag_tags)
  @miquote.attribution.flag_words(flag_tags)
  redirect_to edit  # redirect_to vs render?
end

def edit
  #this will point to the view that the user interacts with
end

def update
  #done when user enters words and clicks submit
end

def destroy
end
