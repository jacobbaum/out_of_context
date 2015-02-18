class Title < ActiveRecord::Base
  belongs_to :misquotable
  has_many :words, as: :token

  validates :text, presence: true, length: { maximum: 254 }
  validates :altered_text, length: { maximum: 254 }

  def flag_tags
    patterns =  { 'vb'  => 'mlnvb',
                  'vbd' => 'mlvbd',
                  'vbg' => 'mlvbg',
                  'vbg' => 'mlvbg' }
    tag_string = tags_to_s
    patterns.each do |pattern, replacement|
      tag_string.gsub!(pattern, replacement)
    end
    tag_string.split(' ')
  end

  def flag_words(flagged_tags)
    word_indexes = flagged_tags.each_index.select do |i| 
      flagged_tags[i].include?('ml') 
    end
    word_array = words
    word_indexes.each do |i_num|
      word_array[i_num].update(replace?: true)
    end 
    return word_array 
  end

  def tags_to_s
    tagger = EngTagger.new
    tagger.tag_string(text)
  end
end
