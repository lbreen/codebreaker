require_relative '../app'

describe "unscramble word" do
  it "'ehllo' should return as 'hello'" do
    initialize_program
    expect(unscramble_word("ehllo")[0]['word']).to eq("hello")
  end
end
