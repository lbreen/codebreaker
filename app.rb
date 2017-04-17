require 'rest-client'
require 'json'

def initialize_program
  @dictionary = JSON.parse(File.read('dictionary.json'))
end

def unscramble_word(scrambled_word)
  # Select words from the dictionary array which have the same letters
  @dictionary[scrambled_word.length.to_s].select { |hash| hash['word'].chars.sort == scrambled_word.chars.sort }
end

def find_definitions(word_hashes)
  # Retrieve the app_id and app_key values
  app_id = JSON.parse(File.read('keys.json'))['APP_ID']
  app_key = JSON.parse(File.read('keys.json'))['APP_KEY']

  # Iterate over each unscrambled word to retrieve their definition
  word_hashes.each do |word_hash|
    if word_hash['definition'].empty? || word_hash['definition'] == 'No definition found - Please check your internet connection'
      # Construct the request url
      url = "https://od-api.oxforddictionaries.com/api/v1/entries/en/#{word_hash['word']}"
      begin
        # Make request to the dictionary api
        response = RestClient.get url, 'app_id' => app_id, 'app_key' => app_key

        # Parse the api response and access the definition.
        # Simultaneously, construct the definitions hash with the unscrambled
        # word as the key and the definition as the value
        word_hash['definition'] = JSON.parse(response.body)['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0].capitalize

        # Rescue RestClient in case of any exceptions and state 'No definition found'
        # in the definitions hash
      rescue RestClient::ExceptionWithResponse
        word_hash['definition'] = 'No definition found - Not in the dictionary'
      rescue SocketError
        word_hash['definition'] = 'No definition found - Please check your internet connection'
      end
      # Update the dictionary with the definition in order to reduce the number of API calls
      update_dictionary_definition(word_hash)
    end
  end
  word_hashes
end

def add_word_to_dictionary(new_word, definition)
  key = new_word.length.to_s

  # If it is the first word of that length, create a new array
  @dictionary[key] = [] if @dictionary[key].nil?

  if @dictionary[key].select { |word_hash| word_hash['word'] == new_word }.empty?
    # If the word is not in the dictionary, add it
    @dictionary[key] << { word: new_word, definition: definition }
    puts "#{new_word.capitalize} has been added to the dictionary!"
  else
    # If the word is already in the dictionary, do not add it
    puts "#{new_word.capitalize} is already in the dictionary."
  end
  File.open('dictionary.json', 'w') { |f| f.write(JSON.pretty_generate(@dictionary)) }
end

def update_dictionary_definition(updated_word_hash)
  new_word = updated_word_hash['word']
  definition = updated_word_hash['definition']

  @dictionary[new_word.length.to_s].select { |word_hash| word_hash['word'] == new_word }[0]['definition'] = definition

  File.open('dictionary.json', 'w') { |f| f.write(JSON.pretty_generate(@dictionary)) }
end

initialize_program

puts 'Select option 1 or 2'
puts '1 - Unscramble a word'
puts '2 - Add a word to the dictionary'
print '> '
option = gets.chomp

if option.to_i == 1
  # Basic terminal user interface
  puts 'What is the scrambled word?'
  print '> '
  input = gets.chomp.downcase
  print `clear`
  puts 'Possible answers: '

  unscrambled_words = unscramble_word(input)
  definitions = find_definitions(unscrambled_words)

  # Display possible unscrambled words with their definitions
  definitions.each_with_index do |word_hash, index|
    puts "#{index + 1}) #{word_hash['word']} -> #{word_hash['definition']}"
  end

elsif option.to_i == 2
  puts 'Enter the new word'
  print '> '
  word = gets.chomp.downcase
  puts "How do you define \"#{word}\"?"
  print '> '
  definition = gets.chomp
  add_word_to_dictionary(word, definition)
else
  'Incorrect input'
end
