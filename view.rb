class View
  def request_word(message)
    puts message
    print "> "
    word = gets.chomp.downcase
  end

  def list_unscrambled_words(word_hashes)
    # Display possible unscrambled words with their definitions
    puts ""
    word_hashes.each_with_index do |word_hash, index|
      puts "#{index + 1}) #{word_hash['word']} -> #{word_hash['definition']}"
    end
  end

  def add_word
    puts "What word do you want to add to the dictionary?"
    print "> "
    word = gets.chomp
    puts "What is the defintion of #{word}?"
    print "> "
    definition = gets.chomp
    {'word' => word, 'definition' => definition}
  end

  def confirm_word_added(success, word)
    if success
      puts "#{word.capitalize} has been added to the dictionary!"
    else
      puts "#{word.capitalize} is already in the dictionary."
    end
  end
end
