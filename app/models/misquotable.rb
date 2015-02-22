class Misquotable < ActiveRecord::Base
  include NprApi

  has_many :sections
  has_many :words, through: :sections

  accepts_nested_attributes_for :sections
  # accepts_nested_attributes_for :words
 
  belongs_to :topic
  #TODO if _json.count> 1, create from extras, prompt user


  def make_sections(filtered_json)
    story = filtered_json.first
      update(npr_id: story['id'], link: story['link'][0]['$text']) 
      sections.create(text: story['title']['$text'], 
                      name: 'title')
      sections.create(text: story['pullQuote'][0]['text']['$text'], 
                      name: 'quote') 
      sections.create(text: story['pullQuote'][0]['person']['$text'], 
                      name: 'attribution')
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
  end

  def make_substitutions
    sections.each do |section|
      section.find_subs.flag_subs
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
      section.altered_text.titleize if section.name == 'title'
    end
    return self
  end

# # "query"=>"slowness", "query_type"=>"search", 

  def npr_create(query_type, query)
    query = topic.code if query_type = 'topic'
    make_sections(NprApi.url(query_type, query).json.filter_json)
    make_words
    make_substitutions
  end


  # def tags_to_s
  #   tagger = EngTagger.new
  #   tagger.tag_string(text)
  # end

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

end

