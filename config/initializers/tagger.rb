EngTagger.class_eval do
  
  # def worry(text, verbose = false)
  #   return nil unless valid_text(text)
  #   tagged = []
  #   words = clean_text(text)
  #   tags = Array.new
  #   words.each do |word|
  #     cleaned_word = clean_word(word)
  #     tag = assign_tag(@conf[:current_tag], cleaned_word)
  #     @conf[:current_tag] = tag = (tag and tag != "") ? tag : 'nn'
  #     tag = EngTagger.explain_tag(tag) if verbose
  #     words << word
  #   end
  #   reset
  #   return words
  # end
  def tag_word_hash(text, verbose = false)
    return nil unless valid_text(text)
    tagged = []
    words = clean_text(text)
    tags = Array.new
    words.each do |word|
      cleaned_word = clean_word(word)
      tag = assign_tag(@conf[:current_tag], cleaned_word)
      @conf[:current_tag] = tag = (tag and tag != "") ? tag : 'nn'
      tag = EngTagger.explain_tag(tag) if verbose
      tagged <<  { tag => word }
    end
    reset
    return tagged
  end

  def tag_string(text, verbose = false)
    return nil unless valid_text(text)
    tagged = []
    words = clean_text(text)
    tags = Array.new
    words.each do |word|
      cleaned_word = clean_word(word)
      tag = assign_tag(@conf[:current_tag], cleaned_word)
      @conf[:current_tag] = tag = (tag and tag != "") ? tag : 'nn'
      tag = EngTagger.explain_tag(tag) if verbose
      tags << tag
    end
    reset
    return tags.join(' ')
  end

  def tag_array(text, verbose = false)
    return nil unless valid_text(text)
    tagged = []
    words = clean_text(text)
    tags = Array.new
    words.each do |word|
      cleaned_word = clean_word(word)
      tag = assign_tag(@conf[:current_tag], cleaned_word)
      @conf[:current_tag] = tag = (tag and tag != "") ? tag : 'nn'
      tag = EngTagger.explain_tag(tag) if verbose
      tags << tag
    end
    reset
    return tags
  end

  def word_string(text, verbose = false)
    return nil unless valid_text(text)
    words = clean_text(text)
    words.each do |word|
      clean_word(word)
    end
    reset
    return words.join(' ')
  end

  def word_array(text, verbose = false)
    return nil unless valid_text(text)
    words = clean_text(text)
    words.each do |word|
      clean_word(word)
    end
    reset #necessary?
    return words
  end

  def count_word_occurences(array_of_words)
    counts = Hash.new(0)
    array_of_words.each do |word|
      word = stem(word)
      next unless word.length < 100  # sanity check on word length
      counts[word] += 1 unless word =~ (/\A\s*\z/ || /\A.{1,3}\z/)
    end
    return counts
  end

  def get_repeated_words(array_of_words)
    counts = Hash.new(0)
    array_of_words.each do |word|
      word = stem(word)
      next unless word.length < 100  # sanity check on word length
      counts[word] += 1 unless word =~ (/\A\s*\z/ || /\A.{1,3}\z/)
    end
    popular_words = []
    counts.each do |word, count|
      popular_words << word if count > 1
    end
    return popular_words
  end

end