require 'rest-client'
require 'json'

# def unscramble_word(scrambled_word)
#   # Import all the words from the dictionary file into an array
#   dictionary = JSON.parse(File.read("dictionary.json"))

#   # Select words from the dictionary array which have the same letters
#   dictionary[scrambled_word.length.to_s].select { |word| word.chars.sort == scrambled_word.chars.sort }
# end

# def find_definitions(words)
#   # Retrieve the app_id and app_key values
#   app_id = JSON.parse(File.read('keys.json'))["APP_ID"]
#   app_key = JSON.parse(File.read('keys.json'))["APP_KEY"]

#   definitions = {}

#   # Iterate over each unscrambled word to retrieve their definition
#   words.each do |word|
#     # Construct the request url
#     url = "https://od-api.oxforddictionaries.com/api/v1/entries/en/#{word}"
#     begin
#       # Make request to the dictionary api
#       response = RestClient.get url, {'app_id' => app_id, 'app_key' => app_key, timeout: 10, open_timeout: 10}

#       # Parse the api response and access the definition from the parsed_response.
#       # Simultaneously, construct the definitions hash with the unscrambled word
#       # as the key and the definition as the value
#       definitions[word.capitalize] = JSON.parse(response.body)['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0].capitalize

#       # Rescue RestClient in case of any exceptions and state 'No definition found'
#       # in the definitions hash
#       rescue RestClient::ExceptionWithResponse => e
#         definitions[word.capitalize] = "No definition found"
#     end
#   end
#   definitions
# end

# def add_word_to_dictionary(new_word)
#   # Retrieve the dictionary
#

#   # If it is the first word of that length, create a new array
#   dictionary[new_word.length.to_s] = [] if dictionary[new_word.length.to_s].nil?

#   if dictionary[new_word.length.to_s].select{ |word| word == new_word }.empty?
#     # If the word is not in the dictionary, add it
#     dictionary[new_word.length.to_s] << new_word
#     puts "#{new_word.capitalize} has been added to the dictionary!"
#   else
#     # If the word is already in the dictionary, do not add it
#     puts "#{new_word.capitalize} is already in the dictionary."
#   end
#   File.open("dictionary.json","w") { |f| f.write(JSON.pretty_generate(dictionary)) }
# end

# puts "Select option 1 or 2"
# puts "1 - Unscramble a word"
# puts "2 - Add a word to the dictionary"
# print "> "
# option = gets.chomp

# if option.to_i == 1
#   # Basic terminal user interface
#   puts "What is the scrambled word?"
#   print "> "
#   input = gets.chomp
#   puts ""
#   puts "Possible answers: "

#   unscrambled_words = unscramble_word(input)
#   definitions = find_definitions(unscrambled_words)

#   # Display possible unscrambled words with their definitions
#   definitions.each { |word, definition| puts "#{word} -> #{definition}" }
# elsif option.to_i == 2
#   puts "Enter the new word"
#   input = gets.chomp
#   add_word_to_dictionary(input)
# else
#   "Incorrect input"
# end

dictionary = JSON.parse(File.read("dictionary.json"))

dictionary.each do |key, value|
  value.map! { |word| {word: word, definition: ""} }
end

File.open("dictionary.json","w") { |f| f.write(JSON.pretty_generate(dictionary)) }
