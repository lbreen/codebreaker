require 'json'
require 'rest-client'
require_relative 'view'
require_relative 'word'

class Controller

  def initialize(dictionary)
    @dictionary = dictionary
    @view = View.new
  end

  def unscramble_word
    # Request word from user
    scrambled_word = @view.request_word("What is the scrambled word?")

    # Select words from the dictionary array which have the same letters
    unscrambled_words = @dictionary.all[scrambled_word.length.to_s].select { |hash| hash['word'].chars.sort == scrambled_word.chars.sort }

    # List the word possibilities with definitions
    @view.list_unscrambled_words(find_api_definitions(unscrambled_words))
  end

  def add_word
    # Request the new word and definition from the user.
    new_word = Word.new(@view.add_word)

    # If not in the dictionary, add the new word and return true. Else,
    # do not add the word and return false.
    success = @dictionary.add_word(new_word)

    # Inform the user if the new word was successfully added, or not.
    @view.confirm_word_added(success, new_word.word)
  end

  def edit_definition
    word = @view.request_word("Please enter the word you wish to edit.")

    # Retrieve the word from the dictionary
    @dictionary.show(word)
  end

  private

  def find_api_definitions(word_hashes)
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
        @dictionary.update(word_hash)
      end
    end
    word_hashes
  end

end
