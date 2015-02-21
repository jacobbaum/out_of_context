class Misquotable < ActiveRecord::Base
  include NprApi

  has_many :sections
  has_many :words, through: :sections
 
  belongs_to :topic

  #TODO rewrite below with active record create methods
  def make_sections(filtered_json)
    filtered_json.each do |story|
      update(npr_id: story['id'], link: story['link'][0]['$text'], 
             sections: Section.create(text: story['title']['$text'], 
                                      type: 'title'),
                       Section.create(text: story['pullQuote'][0]['text']['$text'], 
                                      type: 'quote'), 
                       Section.create(text: story['pullQuote'][0]['person']['$text'], 
                                      type: 'attribution'))
    end
  end

#   def make_words
#     tagger = EngTagger.new
#     [title, quote, attribution].each do |section|
#       tagger.tag_word_hash(section.text).each do |t_w_hash|
#         t_w_hash.each do |tag, word|
#           section.words.create(text: word, pos_tag: PosTag.find_by_tag(tag.upcase))
#         end
#       end
#     end
#   end

# # "query"=>"slowness", "query_type"=>"search", 

#   def npr_create (query_type, query)
#     make_sections(NprApi.url(query_type, query).json.filter_json)
#     make_words
#     title_flag_words(title_flag_tags)
#     quote_flag_words(quote_flag_tags)
#     attribution_flag_words(attribution_flag_tags)
#   end

# # for individual sections
#   def tags_to_s
#     tagger = EngTagger.new
#     tagger.tag_string(text)
#   end

#   #title words 
#   def title_flag_tags
#     patterns =  { 'vb'  => 'mlnvb',
#                   'vbd' => 'mlvbd',
#                   'vbg' => 'mlvbg',
#                   'vbg' => 'mlvbg' }
#     tag_string = title.tags_to_s
#     patterns.each do |pattern, replacement|
#       tag_string.gsub!(pattern, replacement)
#     end
#     tag_string.split(' ')
#   end

#   def title_flag_words(flagged_tags)
#     word_indexes = flagged_tags.each_index.select do |i| 
#       flagged_tags[i].include?('ml') 
#     end
#     word_array = title.words.reverse
#     word_indexes.each do |i_num|
#       word_array[i_num].update(replace?: true)
#     end 
#     # return word_array 
#   end

#   #quote words 
#   def quote_flag_tags
#     patterns =  { 'vb cc vb'  => 'mlvb cc mlvb',
#                   'nn nn'     => 'mlnn nn'     ,
#                   'prps nn'   => 'prps mlnn'   ,
#                   'jjs nn'    => 'jjs mlnn'    ,
#                   'jj jj nn'  => 'jj jj mlnn'  ,
#                   'in det nn' => 'in det mlnn'  }
#     tag_string = quote.tags_to_s
#     patterns.each do |pattern, replacement|
#       tag_string.gsub!(pattern, replacement)
#     end
#     tag_string.split(' ')
#   end

#   def quote_flag_words(flagged_tags)
#     word_indexes = flagged_tags.each_index.select do |i| 
#       flagged_tags[i].include?('ml') 
#     end
#     word_array = quote.words.reverse
#     word_indexes.each do |i_num|
#       word_array[i_num].update(replace?: true)
#     end 
#     # return word_array 
#   end

#   #attribution words
#   def attribution_flag_tags
#     patterns =  { 'prp vbd'  => 'prp mlvbd' }
#     tag_string = attribution.tags_to_s
#     patterns.each do |pattern, replacement|
#       tag_string.gsub!(pattern, replacement)
#     end
#     tag_string.split(' ')
#   end

#   def attribution_flag_words(flagged_tags)
#     word_indexes = flagged_tags.each_index.select do |i| 
#       flagged_tags[i].include?('ml') 
#     end
#     word_array = attribution.words.reverse
#     word_indexes.each do |i_num|
#       word_array[i_num].update(replace?: true)
#     end 
#     # return word_array 
#   end

#   def attribution_name_tags
#     if attribution.tags_to_s.match('nnp nnp ppc')[0]
#       words[0].update(pos_tag_id: 45, replace?: true)
#       words[1].update(pos_tag_id: 46, replace?: true)
#     end
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


