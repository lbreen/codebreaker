require 'rest-client'
require 'json'

def unscramble_word(scrambled_word)
  # Import all the words from the dictionary file into an array
  dictionary = JSON.parse(File.read("dictionary.json"))

  # Select words from the dictionary array which have the same letters
  dictionary[scrambled_word.length.to_s].select { |word| word.chars.sort == scrambled_word.chars.sort }
end

def find_definitions(words)
  # Retrieve the app_id and app_key values
  app_id = JSON.parse(File.read('keys.json'))["APP_ID"]
  app_key = JSON.parse(File.read('keys.json'))["APP_KEY"]

  definitions = {}

  # # Iterate over each unscrambled word to retrieve their definition
  # words.each do |word|
  #   # Construct the request url
  #   url = "https://od-api.oxforddictionaries.com/api/v1/entries/en/#{word}"
  #   begin
  #     # Make request to the dictionary api
  #     response = RestClient.get url, {'app_id' => app_id, 'app_key' => app_key}

  #     # Parse the api response and access the definition from the parsed_response.
  #     # Simultaneously, construct the definitions hash with the unscrambled word
  #     # as the key and the definition as the value
  #     definitions[word.capitalize] = JSON.parse(response.body)['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0].capitalize

  #     # Rescue RestClient in case of any exceptions and state 'No definition found'
  #     # in the definitions hash
  #     rescue RestClient::ExceptionWithResponse => e
  #       definitions[word.capitalize] = "No definition found"
  #   end
  # end
  definitions
end

def csv_to_json(csv_file_path, json_file_path)
  csv_file = []
  json_file = {}

  File.read(csv_file_path).each_line { |line| csv_file << line.slice(0..-2) }

  csv_file.each do |word|
    json_file[word.length] = [] if json_file[word.length].nil?

    json_file[word.length] << word
  end

  File.open(json_file_path,"w") { |f| f.write(JSON.pretty_generate(json_file)) }
end

def add_word_to_dictionary(new_word)
  # Retrieve the dictionary
  # Access the array for words of the same length
  # If the word is already in the dictionary, do not add it
  # If the word is not in the dictionary, add it
  # If
  dictionary = JSON.parse(File.read("dictionary.json"))

  if dictionary[new_word.length.to_s].select{ |word| word == new_word }.empty?
    dictionary[new_word.length.to_s] << new_word
  else
    puts "#{new_word.capitalize} is already in the dictionary."
  end
end
puts "New word"
input = gets.chomp
add_word_to_dictionary(input)

# # Basic terminal user interface
# puts "What is the scrambled word?"
# input = gets.chomp
# puts ""
# puts "Possible answers: "

# unscrambled_words = unscramble_word(input)
# definitions = find_definitions(unscrambled_words)

# # Display possible unscrambled words with their definitions
# definitions.each { |word, definition| puts "#{word} -> #{definition}"}

