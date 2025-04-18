class Hangman
  MAX_ATTEMPTS = 7
  attr_accessor :guessed, :attempts
  attr_reader :secret_word

  def setup(secret_word, guessed = nil, attempts)
    @secret_word = secret_word
    @guessed = guessed == nil ? '_' * secret_word.size : guessed
    @attempts = attempts
  end

  def play
    UI.welcome_message
    if HangmanIO.folder_exist?(HangmanIO::SAVED_GAMES_FOLDER) && UI.load_game? == 'y'
      selected = UI.select_save_filename
      data = HangmanIO.load_game("#{HangmanIO::SAVED_GAMES_FOLDER}/#{selected}")
      setup(data[:secret_word], data[:guessed], data[:attempts])
      UI.loaded
    else
      setup(random_word, 0)
    end
    while (attempts < MAX_ATTEMPTS && guessed != secret_word)
      UI.drawing(attempts, guessed)
      HangmanIO.save_game(serialize) if UI.save_game? == 'y'
      char_guess = UI.instruction
      if (secret_word.include?(char_guess))
        unblank(char_guess)
      else
        self.attempts += 1
      end
    end

    UI.drawing(attempts, guessed)
    UI.results(guessed == secret_word ? true : false, secret_word)
  end

  def serialize
    {
      :secret_word => secret_word,
      :guessed => guessed,
      :attempts => attempts
    }
  end

  def unblank(char_guess)
    secret_word.split('').each_with_index do |c, idx|
      guessed[idx] = char_guess if c == char_guess
    end
  end

  def random_word
    File.readlines('./lib/words.txt').select { |word| word.size.between?(6, 13)}.sample.strip
  end
end
