def unscramble_word(scrambled_word)
  permutations = scrambled_word.split('').permutation.to_a

  p permutations.map{ |word| word.join("")}
end

word = "lelho"
unscramble_word(word)
