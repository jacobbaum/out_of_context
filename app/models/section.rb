class Section < ActiveRecord::Base
  attr_accessor :tag_string
  attr_accessor :tag_array

  belongs_to :misquotable
  has_many :words

  accepts_nested_attributes_for :words

  validates :text, presence: true

  def tags_to_s
    tagger = EngTagger.new
    @tag_string = tagger.tag_string(text)
  end

  def find_subs
    patterns =  { 
                  'in vbg'     => 'in mlvbg',
                  'vb cc vb'   => 'mlvb cc mlvb',
                  'nn nn'      => 'mlnn nn',
                  'nns nn'     => 'mlnns nn',
                  'prps nn'    => 'prps mlnn',
                  'jjs nn'     => 'jjs mlnn',
                  'jj jj nn'   => 'jj jj mlnn',
                  'in det nn'  => 'in det mlnn',
                  'rb jj'      => 'mlrb jj', 
                  'ppc rb ppc' => 'ppc mlrb ppc',
                  'nn in nn'   => 'mlnn in mlnn', 
                  'rb vbn'     => 'rb mlrbn', 
                  'uh'         => 'mluh',
                  'jjs'        => 'mljjs',
                  'rbs'        => 'mlrbs',
                  'cd'         => 'mlcd'
                }
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
    return self 
  end

  def ing_replace
    if name == 'question' && words[1].text.end_with?('ing')
      words[1].update(pos_tag: PosTag.find_by_tag('VBG'),
                      replace?: true)
    end
  end
  
end
