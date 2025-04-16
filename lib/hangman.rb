class Hangman
  MAX_ATTEMPTS = 6

  def play
    secret_word = random_word
    current_attempt = 0
  end


  def random_word
    File.readlines('./lib/words.txt').select { |word| word.size.between?(6, 13)}.sample.strip
  end
end
