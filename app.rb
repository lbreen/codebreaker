require 'rest-client'
require 'json'

def unscramble_word(scrambled_word)
  dictionary_words = []

  File.open("dictionary.csv", "r").each_line { |line| dictionary_words << line }
  answers = dictionary_words.select { |word| word.chars.sort.drop(1) == scrambled_word.chars.sort }

  return answers.map {|answer| answer.slice!(0..-2)}
end

def find_definitions(words)
  app_id = JSON.parse(File.read('keys.json'))["APP_ID"]
  app_key = JSON.parse(File.read('keys.json'))["APP_KEY"]

  definitions = {}

  words.each do |word|
    url = "https://od-api.oxforddictionaries.com/api/v1/entries/en/#{word}"
    begin
      response = RestClient.get url, {'app_id' => app_id, 'app_key' => app_key}

      definitions[word.capitalize] = JSON.parse(response.body)['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0].capitalize

      rescue RestClient::ExceptionWithResponse => e
        definitions[word.capitalize] = "No definition found"
    end
  end
  definitions
end


puts "What is the scrambled word?"
word = gets.chomp
puts ""
puts "Possible answers: "
unscrambled_words = unscramble_word(word)
definitions = find_definitions(unscrambled_words)

definitions.each { |word, definition| puts "#{word} -> #{definition}"}
