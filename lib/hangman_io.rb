require 'yaml'

module HangmanIO
  SAVED_GAMES_FOLDER = 'saved_games'

  def self.folder_exist?(location)
    Dir.exist?("#{location}")
  end

  def self.save_filenames
    #Regex Expressions for files ending with .yaml excepting '.' or '..'
    Dir.entries(SAVED_GAMES_FOLDER).filter {|name| name.match?(/\A(?!\.{1,2}$)[^\/:*?"<>|\\]+\.yaml\z/)}
  end

  def self.save_game(serialized)
    Dir.mkdir(SAVED_GAMES_FOLDER) unless Dir.exist?(SAVED_GAMES_FOLDER)
    latest_save_filename = save_filenames.map {|name| name.split('.')[0].to_i}.max
    File.write("#{SAVED_GAMES_FOLDER}/#{latest_save_filename + 1}.yaml", YAML.dump(serialized)
    )
  end

  def self.load_game(location)
    YAML.load_file(location)
  end
end