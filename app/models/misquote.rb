class Misquote < ActiveRecord::Base
  has_many :sections, dependent: :destroy
  has_many :words, through: :sections

  belongs_to :user
 
  def self.get_npr(search_term)

    search_term.strip!
    search_term.gsub!(' ', '%20')

    url = "https://api.npr.org/query?id=1022&fields=title,text&requiredAssets=text&"
    url << "searchTerm=#{search_term}%20%22interview%20highlights%22&date"
    url << "Type=story&output=JSON&apiKey=MDE4MjMzNDczMDE0MjM2MDYxOTBiMDU5MQ001"

    npr = JSON.parse(HTTParty.get(url))

    matches = []

    if npr['message']
      return 'no matches'
    else
      npr['list']['story'].each do |story|
        paras = story['text']['paragraph']

        highlights_index = 
          paras.index { |par| par['$text'] == 'Interview Highlights' }

        paras.slice!(0,highlights_index) if highlights_index 

        paras.delete_if { |par| !par['$text'] }

        paras.each_index do |i|
          if paras[i] && paras[i+1]
            if paras[i]['$text'].start_with?('On') && paras[i+1]['$text'].length.between?(49, 500)
              match = Misquote.new(npr_id: story['id'], 
                                   title: story['title']['$text'], 
                                   link: story['link'][0]['$text'],
                                   search_term: search_term) 
              match.sections.new(name: 'question', text: paras[i]['$text']) 
              match.sections.new(name: 'answer', text: paras[i+1]['$text'])                      
              matches << match
            end
          end
        end
      end
      match = matches.sample
      match.save
      return match
    end
  end

  def make_words
    tagger = EngTagger.new
    sections.each do |section|
      tagger.tag_word_hash(section.text).each do |t_w_hash|
        t_w_hash.each do |tag, word|
          section.words.create(text: word, pos_tag: PosTag.find_by_tag(tag.upcase))
        end
      end
    end
    return self
  end

  def make_substitutions
    sections.each do |section|
      section.find_subs.flag_subs.ing_replace
    end
    return
  end

  def self.create_from_search(search_term)
    mq = self.get_npr(search_term)
    if mq == 'no matches' 
      return 'no matches'
    else
     mq.make_words.make_substitutions  
     return mq  
    end
  end


  def make_altered_text
    sections.each do |section|
      section.altered_text = ""
      section.words.order(:id).each do |word|
        if word.replace?
          section.altered_text << word.replacement + ' '
        else
          section.altered_text << word.text + ' '
        end
      end
      section.altered_text.gsub!(/\s[!?,.']/, ' !' => '!', ' ?' => '?',
                                              ' ,' => ',', ' .' => '.', 
                                              " '" => "'")
      section.altered_text.titleize if section.name == 'title'
    end
    return self
  end

end
