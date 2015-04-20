require 'pry'
require 'httparty'
require './npr_classes'

puts 'Hello.'

# some_story = Story.new
# some_story = Story.new(npr_id: 12, title: 'Great Title', link: 'good luck')


# so far so something

url = "https://api.npr.org/query?id=1022&fields=title,text&requiredAssets=text&"
url << "searchTerm=dog%20%22interview%20highlights%22&date"
url << "Type=story&output=JSON&apiKey=MDE4MjMzNDczMDE0MjM2MDYxOTBiMDU5MQ001"

npr = JSON.parse(HTTParty.get(url))


# npr['list']['story'][0]['title']['$text']
# npr['list']['story'][0]['link'][2]['$text']
# npr['list']['story'][0]['id']

# Story.new(npr_id: 12, title: 'Great Title', link: 'good luck')




npr['list']['story'].each do |story|
  Story.new(npr_id: story['id'],
            title: story['title']['$text'],
            link: story['link'][2]['$text'])

  paras = story['text']['paragraph']

  highlights_index =
    paras.index { |par| par['$text'] == 'Interview Highlights' }

  paras.slice!(0,highlights_index)

  paras.delete_if { |par| !par['$text'] }

  paras.each_index do |i|
    if paras[i]['$text'].start_with?('On') && paras[i+1]['$text'].length > 300
      m = Misquote.new(question: paras[i]['$text'], answer: paras[i+1]['$text'])
      puts m
    end
  end

end

binding.pry

# npr['list']['story'].each do |story|
  # highlights_index =
  # story['text']['paragraph'].index do |paragraph|
  #     paragraph['$text'] == 'Interview Highlights'
  # end

  # story['text']['paragraph'].slice!(0,highlights_index)

  # story['text']['paragraph'].delete_if do |paragraph|
  #   !paragraph['$text']
  # end

#   story['text']['paragraph'] = paragraphs

#   paragraphs.each_index do |i|
#     if paragraphs[i][$text]?
#       if  paragraphs[i]['$text'].start_with?('On') && 
#           paragraphs[i+1]['$text'].length > 300


# end

highlights_index = 
npr['list']['story'][0]['text']['paragraph'].index do |paragraph|
  paragraph['$text'] == 'Interview Highlights'
end

story['text']['paragraph'].slice!(0,highlights_index)


ih_i =
filtered[0]['text']['paragraph'].index do |paragraph|
  paragraph['$text'] == 'Interview Highlights'
end

q_and_a =
filtered[0]['text']['paragraph'].drop(ih_i)

npr['list']['story'].each do |story|
  story['text'].each do |paragraph|
     if paragraph['$text'] == 'Interview Highlights'
      puts 'Great.'
    end
  end
end

npr['list']['story'].map do |story|
  puts story['title']['$text']
end

filtered =
npr['list']['story'].select do |story|
  story['text']['paragraph'].any? do |paragraph|
    paragraph['$text'] == 'Interview Highlights'
  end
end

# filtered.each do |story|
#   story['text']['paragraph'].each do |paragraph|
#     if paragraph['$text'] == 'Interview Highlights'




winner = []
q_and_a.each_index do |i|
  if q_and_a[i]['$text'].length < 100 && q_and_a[i+1]['$text'].length > 300
    winner = q_and_a[i,2]
  end
end

filtered[0]['text']['paragraph'][ih_i + 1]['text'].length

  # story['text']['paragraph'].each do |paragraph|
  #   if paragraph['$text'] == 'Interview Highlights'


# "hello".start_with?("hell") 

# new url:
# "https://api.npr.org/query?id=1022&fields=title,text&requiredAssets=text&searchTerm=#{search_terms}%20%22interview%20highlights%22&dateType=story&output=JSON&apiKey=MDE4MjMzNDczMDE0MjM2MDYxOTBiMDU5MQ001




# path to "Interview Highlights" text:
# list.story[6].text.paragraph[13].$text
