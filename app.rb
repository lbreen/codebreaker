def unscramble_word(scrambled_word)
  #permutations = scrambled_word.chars.permutation.to_a.map{ |word| word.join("")}

  words = []

  File.open("dictionary.txt", "r").each_line { |line| words << line }

  answers = words.select { |word| word.chars.sort.drop(1) == scrambled_word.chars.sort }

  return answers
end

puts "What is the cyphertext?"
word = gets.chomp
puts ""
puts "Possible answers: "
unscramble_word(word).each { |word| puts "- #{word.capitalize}" }

