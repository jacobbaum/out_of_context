class Quote < ActiveRecord::Base
  belongs_to :misquotable
  has_many :words, as: :token

  accepts_nested_attributes_for :words

  validates :text, presence: true

  def flag_tags
    patterns =  { 'vb cc vb'  => 'mlvb cc mlvb',
                  'nn nn'     => 'mlnn nn'     ,
                  'prps nn'   => 'prps mlnn'   ,
                  'jjs nn'    => 'jjs mlnn'    ,
                  'in det nn' => 'in det mlnn'  }
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