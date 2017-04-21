class View
  def request_word
    puts "What is the scrambled word?"
    print "> "
    word = gets.chomp
  end

  def list_unscrambled_words(word_hashes)
    # Display possible unscrambled words with their definitions
    puts ""
    word_hashes.each_with_index do |word_hash, index|
      puts "#{index + 1}) #{word_hash['word']} -> #{word_hash['definition']}"
    end
  end
end
