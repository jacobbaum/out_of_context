module NprApi
  @npr_json   = Hash.new
  @npr_quotes = Array.new

  #still necessary
  def npr_quotes
    @npr_quotes
  end
    
  def self.get_json(topic_code, start_num)
    id          =   "http://api.npr.org/query?id=#{topic_code}"
    fields      =   "&fields=title,storyDate,pullQuote"
    range       =   "&startNum=#{start_num}&dateType=story&output=JSON&numResults=20"
    api_key     =   "&apiKey=MDE4MjMzNDczMDE0MjM2MDYxOTBiMDU5MQ001"
    
    @npr_json = JSON.parse(HTTParty.get id+fields+range+api_key)
  end

  def self.get_quotes_from_json
    @npr_json['list']['story'].each do |story| 
      if story.has_key?('pullQuote') && story['pullQuote'][0]['person']['$text'] != nil
        @npr_quotes << story 
      end
    end 
    return @npr_quotes
  end
  # add check to see if npr_quotes is empty
  # if it is empty, pull the next twenty stories
  # stop after 60 stories, prompt the user to try a different category 
end


# #search examples - Incorporate if time allows
# "http://api.npr.org/query?fields=title,storyDate,pullQuote,none&searchTerm=general%20assembly&startNum=1&dateType=story&output=JSON&numResults=20&apiKey=MDE4MjMzNDczMDE0MjM2MDYxOTBiMDU5MQ001"
# #search example, double quotes--%22--search for phrase, not individual words
# # "http://api.npr.org/query?fields=title,storyDate,pullQuote&searchTerm=%22general%20assembly%22&startNum=1&dateType=story&output=JSON&numResults=20&apiKey=MDE4MjMzNDczMDE0MjM2MDYxOTBiMDU5MQ001"

# tagger = EngTagger.new

# ml_stories.each do |story|
#   db_story =  Story.create(npr_id: story['id'], link: story['link'][2]['$text'], 
#               title: Title.create(text: story['title']['$text']),
#               quote: Quote.create(text: story['pullQuote'][0]['text']['$text']), 
#               attribution: Attribution.create(text: story['pullQuote'][0]['person']['$text']))





