class Section < ActiveRecord::Base
  attr_accessor :tag_string
  attr_accessor :tag_array

  belongs_to :misquotable
  has_many :words

  accepts_nested_attributes_for :words

  validates :text, presence: true

  def to_key
    [id]
  end

  def tags_to_s
    tagger = EngTagger.new
    @tag_string = tagger.tag_string(text)
  end

  def find_subs
    case name
    when 'title'
      patterns =  { 'vb'  => 'mlvb' }
    when 'quote'
      patterns =  { 'vb cc vb'   => 'mlvb cc mlvb',
                    'nn nn'      => 'mlnn nn'     ,
                    'prps nn'    => 'prps mlnn'   ,
                    'jjs nn'     => 'jjs mlnn'    ,
                    'jj jj nn'   => 'jj jj mlnn'  ,
                    'in det nn'  => 'in det mlnn' ,
                    'rb jj'      => 'mlrb jj'     , 
                    'ppc rb ppc' => 'ppc mlrb ppc',
                    'nn in nn'   => 'mlnn in mlnn'  }
    when 'attribution'
      patterns =  { 'prp vbd'  => 'prp mlvbd' }
    end       
    tags_to_s
    patterns.each do |pattern, replacement|
      tag_string.gsub!(pattern, replacement)
    end
    @tag_array = tag_string.split(' ')
    return self
  end

  def flag_subs
    word_indexes = tag_array.each_index.select do |i| 
      tag_array[i].include?('ml') 
    end
    word_array = words
    word_indexes.each do |i_num|
      word_array[i_num].update(replace?: true)
    end 
    return word_array 
  end
end

