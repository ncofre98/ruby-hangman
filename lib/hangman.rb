class Hangman
  MAX_ATTEMPTS = 7

  def play
    secret_word = random_word
    guessed = "_" * secret_word.size
    attempts = 0

    UI.welcome_message
    while (attempts < MAX_ATTEMPTS && guessed != secret_word)
      UI.drawing(attempts, guessed)
      char_guess = UI.instruction
      if (secret_word.include?(char_guess))
        guessed = unblank(secret_word, guessed, char_guess)
      else
        attempts += 1
      end
    end

    UI.drawing(attempts, guessed)
    UI.results(guessed == secret_word ? true : false, secret_word)
  end

  def unblank(secret_word, guessed, char_guess)
    secret_word.split('').each_with_index do |c, idx|
      guessed[idx] = char_guess if c == char_guess
    end
    guessed
  end

  def random_word
    File.readlines('./lib/words.txt').select { |word| word.size.between?(6, 13)}.sample.strip
  end
end
