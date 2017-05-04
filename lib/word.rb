class Word
  attr_reader :word, :definition

  def initialize(attributes = {})
    @word = attributes['word']
    @definition = attributes['definition']
  end
end
