class Story
  attr_accessor :npr_id, :link, :title, :misquotes

  def initialize(args)
    @npr_id = args[:npr_id]
    @link = args[:link]
    @title = args[:title]
  end

end

class Misquote
  attr_accessor :question, :answer

  def initialize(args)
    @quesion = args[:queston]
    @answer = args[:answer]
  end

end

