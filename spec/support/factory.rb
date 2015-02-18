FactoryGirl.define do 

  factory :attribution do
    text          { "#{Faker::Name.name} #{Faker::Name.title}" }
    altered_text  nil
  end

  factory :quote do
    text          { Faker::Lorem.sentences(2) }
    altered_text  nil
    factory :quote_with_words do
      transient do
        word_count 8
      end
      # after(:create) do |quote, evaluator|
      #   create_list(:word, evaluator.word_count, quote: quote)
      # end
    end
  end

  factory :title do
    text          { Faker::Lorem.sentence(3) }
    altered_text  nil
  end

  factory :misquotable do
    npr_id        { Faker::Number.number(9) }
    link          { Faker::Internet.url('npr.org') }
  end

  factory :word do
    text          { Faker::Lorem.word }
    replacement   { Faker::Lorem.word }
    pos_tag_id    { rand(1..60) }
    replace?      false
    repeat?       false    
  end

end

