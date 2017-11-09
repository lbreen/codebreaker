require 'json'
require 'pry-byebug'

class Dictionary
  def initialize
    @dictionary = JSON.parse(File.read("#{Dir.pwd}/lib/dictionary.json"))
  end

  def all
    @dictionary
  end

  def show(word)
    key = word.length.to_s
    # Retrieve one word and its definition
    @dictionary[key].select { |word_hash| word_hash['word'] == word }[0]
  end

  def add_word(word_params)
    new_word = word_params['word']
    key = new_word.length.to_s

    # If it is the first word of that length, create a new array
    @dictionary[key] = [] if @dictionary[key].nil?

    if @dictionary[key].select { |word_hash| word_hash['word'] == new_word }.empty?
      # If the word is not in the dictionary, add it and return true
      @dictionary[key] << { 'word' => new_word, 'definition' => word_params['definition'] }
      File.open('lib/dictionary.json', 'w') { |f| f.write(JSON.pretty_generate(@dictionary)) }
      true
    else
      # If the word is already in the dictionary, do not add it and return false
      false
    end
  end

  def update(word_params)
    new_word = word_params['word']
    definition = word_params['definition']

    # Access the definition in the word_hash and set it to the new definition
    @dictionary[new_word.length.to_s].select { |word_hash| word_hash['word'] == new_word }[0]['definition'] = definition

    # Save the updated dictionary back in the JSON file
    File.open("#{Dir.pwd}/lib/dictionary.json", 'w') { |f| f.write(JSON.pretty_generate(@dictionary)) }
  end
end
