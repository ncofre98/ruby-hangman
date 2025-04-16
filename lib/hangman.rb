class Hangman

  def initialize
    p random_word
  end


  def random_word
    File.readlines('./lib/words.txt').select {|word| word.size.between?(6, 13)}.sample.strip
  end
end
