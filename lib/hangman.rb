require 'yaml'

class Hangman
  MAX_ATTEMPTS = 7
  attr_accessor :guessed, :attempts
  attr_reader :secret_word

  def setup(secret_word, guessed, attempts)
    @secret_word = secret_word
    @guessed = guessed
    @attempts = attempts
  end

  def play
    UI.welcome_message
    if File.exist?('saved_games/1.yaml') && UI.load_game? == 'y'
      load_game('saved_games/1.yaml')
      UI.loaded
    else
      setup(random_word, "_" * secret_word.size, 0)
    end

    while (attempts < MAX_ATTEMPTS && guessed != secret_word)
      UI.drawing(attempts, guessed)
      save_game if attempts > 0 && UI.save_game? == 'y'
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

  def unblank(char_guess)
    secret_word.split('').each_with_index do |c, idx|
      guessed[idx] = char_guess if c == char_guess
    end
  end


  def save_game
    folder = 'saved_games'
    Dir.mkdir(folder) unless Dir.exist?(folder)
    File.write("#{folder}/1.yaml", YAML.dump({
      :secret_word => secret_word,
      :guessed => guessed,
      :attempts => attempts
    })
    )
  end

  def load_game(location)
    data = YAML.load_file(location)
    setup(data[:secret_word], data[:guessed], data[:attempts])
  end

  def random_word
    File.readlines('./lib/words.txt').select { |word| word.size.between?(6, 13)}.sample.strip
  end
end
