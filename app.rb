require 'rest-client'
require 'json'

def unscramble_word(scrambled_word)
  dictionary_words = []

  # Import all the words from the dictionary file into an array
  File.open("dictionary.csv", "r").each_line { |line| dictionary_words << line }

  # Select words from the dictionary array which have the same letters
  answers = dictionary_words.select { |word| word.chars.sort.drop(1) == scrambled_word.chars.sort }

  # Remove the '\n' characters from the end of each answer then return the answers array
  return answers.map {|answer| answer.slice!(0..-2)}
end

def find_definitions(words)
  # Retrieve the app_id and app_key values
  app_id = JSON.parse(File.read('keys.json'))["APP_ID"]
  app_key = JSON.parse(File.read('keys.json'))["APP_KEY"]

  definitions = {}

  # Iterate over each unscrambled word to retrieve their definition
  words.each do |word|
    # Construct the request url
    url = "https://od-api.oxforddictionaries.com/api/v1/entries/en/#{word}"
    begin
      # Make request to the dictionary api
      response = RestClient.get url, {'app_id' => app_id, 'app_key' => app_key}

      # Parse the api response and access the definition from the parsed_response.
      # Simultaneously, construct the definitions hash with the unscrambled word
      # as the key and the definition as the value
      definitions[word.capitalize] = JSON.parse(response.body)['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0].capitalize

      # Rescue RestClient in case of any exceptions and state 'No definition found'
      # in the definitions hash
      rescue RestClient::ExceptionWithResponse => e
        definitions[word.capitalize] = "No definition found"
    end
  end
  definitions
end

# Basic terminal user interface
puts "What is the scrambled word/sentence?"
input = gets.chomp
puts ""
puts "Possible answers: "

# Simple router to depending on whether the input is a word or a sentence
if input.split(" ").length == 1
  unscrambled_words = unscramble_word(input)
  definitions = find_definitions(unscrambled_words)

  # Display possible unscrambled words with their definitions
  definitions.each { |word, definition| puts "#{word} -> #{definition}"}
else
  unscrambled_sentence = []
  # Split the inputted sentence into its component words and unscramble each word
  input.split(" ").each { |word| unscrambled_sentence << unscramble_word(word) }

  # Retrieve the first possible word and join together to form a sentence
  # TODO: Compute every possible sentence combination
  puts unscrambled_sentence.map { |words| words[0]}.join(" ").capitalize
end
