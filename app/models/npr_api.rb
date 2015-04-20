module NprApi
  @url    = String.new
  @json   = Hash.new
  @quotes = Array.new

  def self.url(query_type, query)    # start_num ||= '1' or similar for making multiple passes?
    base    = "http://api.npr.org/query?" 
    topic   = "id=#{query}&"
    fields  = "fields=title,storyDate,pullQuote"
    search  = "&searchTerm=#{query}" 
    range   = "&startNum=1&dateType=story&output=JSON&numResults=20"
    api_key = "&apiKey=MDE4MjMzNDczMDE0MjM2MDYxOTBiMDU5MQ001"
    if query_type =='topic'
      @url = base+topic+fields+range+api_key
    else  
      @url = base+fields+search+range+api_key
    end
    return self
  end

  def self.json
    @json = JSON.parse(HTTParty.get(@url))
    return self 
  end  

  def self.filter_json
    @json['list']['story'].each do |story| 
      if story.has_key?('pullQuote') && story['pullQuote'][0]['person']['$text'] != nil
        @quotes << story 
      end
    end 
    return @quotes
  end

  def self.quotes?
    @quotes.any?
  end

end

