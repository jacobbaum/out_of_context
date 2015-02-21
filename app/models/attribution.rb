class Attribution < ActiveRecord::Base


  def flag_tags
    patterns =  { 'prp vbd'  => 'prp mlvbd' }
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
    name_tags
  end

  def tags_to_s
    tagger = EngTagger.new
    tagger.tag_string(text)
  end

  def name_tags
    if tags_to_s.match('nnp nnp ppc')[0]
      words[0].update(pos_tag_id: 45, replace?: true)
      words[1].update(pos_tag_id: 46, replace?: true)
    end
  end

end
