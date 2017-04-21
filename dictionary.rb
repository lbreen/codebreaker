require 'json'

class Dictionary

  def initialize
    @dictionary = JSON.parse(File.read('dictionary.json'))
  end

  def all
    @dictionary
  end

  def add_word(new_word_instance)
    new_word = new_word_instance.word
    key = new_word.length.to_s

    # If it is the first word of that length, create a new array
    @dictionary[key] = [] if @dictionary[key].nil?

    if @dictionary[key].select { |word_hash| word_hash['word'] == new_word }.empty?
      # If the word is not in the dictionary, add it and return true
      @dictionary[key] << word_hash
      File.open('dictionary.json', 'w') { |f| f.write(JSON.pretty_generate(@dictionary)) }
      true
    else
      # If the word is already in the dictionary, do not add it and return false
      false
    end
  end
end
