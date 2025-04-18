require 'yaml'
SAVED_GAMES_FOLDER = 'saved_games'

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
    if File.exist?("#{SAVED_GAMES_FOLDER}") && UI.load_game? == 'y'
      selected = UI.select_save_filename
      load_game("#{SAVED_GAMES_FOLDER}/#{selected}")
      UI.loaded
    else
      setup(random_word, 0)
    end
    while (attempts < MAX_ATTEMPTS && guessed != secret_word)
      UI.drawing(attempts, guessed)
      save_game if UI.save_game? == 'y'
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

  def self.save_filenames
    #Regex Expressions for files ending with .yaml excepting '.' or '..'
    Dir.entries(SAVED_GAMES_FOLDER).filter {|name| name.match?(/\A(?!\.{1,2}$)[^\/:*?"<>|\\]+\.yaml\z/)}
  end

  def unblank(char_guess)
    secret_word.split('').each_with_index do |c, idx|
      guessed[idx] = char_guess if c == char_guess
    end
  end

  def save_game
    Dir.mkdir(SAVED_GAMES_FOLDER) unless Dir.exist?(SAVED_GAMES_FOLDER)
    latest_save_filename = Hangman.save_filenames.map {|name| name.split('.')[0].to_i}.max
    File.write("#{SAVED_GAMES_FOLDER}/#{latest_save_filename + 1}.yaml", YAML.dump({
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
