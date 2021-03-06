class View
  def request_input(message)
    puts message
    print '> '
    gets.chomp.downcase
  end

  def display_definition(definition)
    puts "Current definition: #{definition}"
    puts 'Do you want to edit this definition? Yes or No'
    print '> '
    gets.chomp.downcase
  end

  def list_unscrambled_words(word_hashes)
    puts ''
    if word_hashes.empty?
      puts 'Those scrambled letters do not match any word in the dictionary.'
    else
      # Display possible unscrambled words with their definitions
      word_hashes.each_with_index do |word_hash, index|
        puts "#{index + 1}) #{word_hash['word']} -> #{word_hash['definition']}"
      end
    end
  end

  def add_word
    puts 'What word do you want to add to the dictionary?'
    print '> '
    word = gets.chomp.downcase
    puts "What is the defintion of #{word}?"
    print '> '
    definition = gets.chomp.downcase
    { 'word' => word, 'definition' => definition }
  end

  def confirm_word_added(success, word)
    if success
      puts "#{word.capitalize} has been added to the dictionary!"
    else
      puts "#{word.capitalize} is already in the dictionary."
    end
  end

  def confirm_definition_updated(word, definition)
    puts ''
    puts 'Definition updated!'
    puts "Word: #{word.capitalize}"
    puts "Definition: #{definition.capitalize}"
  end

  def display_time_taken(word, time_taken)
    puts ''
    puts "#{word} - #{time_taken}"
  end
end
