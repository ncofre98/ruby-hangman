module UI
  HANGMAN_STATES = [
    '''
  +---+
      |
      |
      |
      |
      |
=========''',
  '''
  +---+
  |   |
      |
      |
      |
      |
=========''', '''
  +---+
  |   |
  O   |
      |
      |
      |
=========''', '''
  +---+
  |   |
  O   |
  |   |
      |
      |
=========''', '''
  +---+
  |   |
  O   |
 /|   |
      |
      |
=========''', '''
  +---+
  |   |
  O   |
 /|\  |
      |
      |
=========''', '''
  +---+
  |   |
  O   |
 /|\  |
 /    |
      |
=========''', '''
  +---+
  |   |
  O   |
 /|\  |
 / \  |
      |
========='''
]


  def self.current_state(number_of_attempt)
    puts HANGMAN_STATES[number_of_attempt]
  end

  def self.instruction
    puts "\nType in the letter of your guess followed by ENTER"
    gets.chomp.downcase
  end

  def self.welcome_message
    puts <<~INSTRUCTIONS
    Welcome to Hangman
    Guess the secret word one letter at a time.
    You have 6 attempts — one wrong guess will make a new drawing
    If you lose all 6, the game is over.
    Good luck!
    INSTRUCTIONS
  end

  def self.load_game?
    puts "Would you like to load your saved game? (y or n)"
    gets.chomp.downcase
  end

  def self.select_save_filename
    files = HangmanIO.save_filenames
    p files
    puts "Choose the number of the file to load (e.g. 1.yaml --> ENTER 1)"
    gets.chomp + '.yaml'
  end

  def self.loaded
    puts "Game loaded successfully!\n"
  end

  def self.save_game?
    puts "Would you like to save your game? (y or n)"
    gets.chomp.downcase
  end

  def self.hidden_word(word)
    puts word
  end

  def self.drawing(attempts, word)
    current_state(attempts)
    hidden_word(word)
  end

  def self.results(winner, secret_word)
    puts
    if (winner)
      puts "Congratulations, you guessed the secret word"
    else
      puts "Too bad, the secret word was #{secret_word}"
    end
  end
end