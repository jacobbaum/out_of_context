class Misquotable < ActiveRecord::Base
  include NprApi

  has_one :title
  has_one :quote
  has_one :attribution
  belongs_to :topic

  accepts_nested_attributes_for :title
  accepts_nested_attributes_for :quote
  accepts_nested_attributes_for :attribution

  # as currently set up, 'Misquotable.last.words', eg, 
  # only returns word from attribution. Fix
  
  has_many :words, through: :quote
  has_many :words, through: :attribution
  has_many :words, through: :title, source: :token

  # valid_url_regex = /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z/
  # validates :link, format: { with: valid_url_regex }

  #TODO rewrite below with active record create methods
  def make_sections(filtered_json)
    filtered_json.each do |story|
      update(npr_id: story['id'], link: story['link'][2]['$text'], 
      title: Title.create(text: story['title']['$text']),
      quote: Quote.create(
      text: story['pullQuote'][0]['text']['$text']), 
      attribution: Attribution.create(
      text: story['pullQuote'][0]['person']['$text']))
    end
  end

  def make_words
    tagger = EngTagger.new
    [title, quote, attribution].each do |section|
      tagger.tag_word_hash(section.text).each do |t_w_hash|
        t_w_hash.each do |tag, word|
          section.words.create(text: word, pos_tag: PosTag.find_by_tag(tag.upcase))
        end
      end
    end
  end

# "query"=>"slowness", "query_type"=>"search", 

  def npr_create (query_type, query)
    make_sections(NprApi.url(query_type, query).json.filter_json)
    make_words
    title_flag_words(title_flag_tags)
    # self.quote.flag_words(flag_tags)  
    # self.attribution.flag_words(flag_tags)
  end

# for individual sections
  def tags_to_s
    tagger = EngTagger.new
    tagger.tag_string(text)
  end

  def title_flag_tags
    patterns =  { 'vb'  => 'mlnvb',
                  'vbd' => 'mlvbd',
                  'vbg' => 'mlvbg',
                  'vbg' => 'mlvbg' }
    tag_string = title.tags_to_s
    patterns.each do |pattern, replacement|
      tag_string.gsub!(pattern, replacement)
    end
    tag_string.split(' ')
  end

  def title_flag_words(flagged_tags)
    word_indexes = flagged_tags.each_index.select do |i| 
      flagged_tags[i].include?('ml') 
    end
    word_array = title.words
    word_indexes.each do |i_num|
      word_array[i_num].update(replace?: true)
    end 
    # return word_array 
  end

end



  # def self.create_from_npr_api(npr_quotes)
  #   npr_quotes.each do |story|
  #     db_quotes = self.create(npr_id: story['id'], link: story['link'][2]['$text'], 
  #                             title: Title.create(text: story['title']['$text']),
  #                             quote: Quote.create(
  #                             text: story['pullQuote'][0]['text']['$text']), 
  #                             attribution: Attribution.create(
  #                             text: story['pullQuote'][0]['person']['$text']))
  #   end
  # end

  # sections are 'title', 'quote' and 'attribution'
  # def self.create_words_with_tags(instance, section)
  #   tagger = EngTagger.new
  #   tagger.tag_word_hash(instance.section.text).each do |t_w_hash|
  #     t_w_hash.each do |tag, word|
  #       instance.section.words.create(text: word, pos_tag: PosTag.find_by_tag(tag.upcase))
  #     end
  #   end
  # end


