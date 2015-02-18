class Misquotable < ActiveRecord::Base

  has_one :title
  has_one :quote
  has_one :attribution
  belongs_to :topic

  # as currently set up, 'Misquotable.last.words', eg, 
  # only returns word from attribution. Fix
  has_many :words, through: :title
  has_many :words, through: :quote
  has_many :words, through: :attribution

  valid_url_regex = /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z/
  validates :link, format: { with: valid_url_regex }

  
  def self.create_from_npr_api(npr_quotes)
    npr_quotes.each do |story|
      db_quote = self.create(npr_id: story['id'], link: story['link'][2]['$text'], 
                 title: Title.create(text: story['title']['$text']),
                 quote: Quote.create(text: story['pullQuote'][0]['text']['$text']), 
                 attribution: Attribution.create(text: story['pullQuote'][0]['person']['$text']))
    end
  end

  # sections are 'title', 'quote' and 'attribution'
  def self.create_words_with_tags(instance, section)
    tagger = EngTagger.new
    tagger.tag_word_hash(instance.section.text).each do |t_w_hash|
      t_w_hash.each do |tag, word|
        instance.section.words.create(text: word, pos_tag: PosTag.find_by_tag(tag.upcase))
      end
    end
  end
    
  def create_words
    tagger = EngTagger.new
    [title, quote, attribution].each do |section|
      tagger.tag_word_hash(section.text).each do |t_w_hash|
        t_w_hash.each do |tag, word|
          section.words.create(text: word, pos_tag: PosTag.find_by_tag(tag.upcase))
        end
      end
    end
  end

end







