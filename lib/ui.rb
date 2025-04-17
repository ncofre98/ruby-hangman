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
    gets.chomp
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
      puts "Too bad, the secret word were #{secret_word}"
    end
  end
end