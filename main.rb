# frozen-string-literal: true

require_relative 'hangman.rb'

# Main interface for Hangman
class Main
  def initialize
    new_or_load
  end

  def user_option
    response = gets.chomp.downcase
    %w[1 2 q].include?(response) ? response : invalid_response
  end

  def new_or_load
    puts "Greetings esteemed user. You can:\n\t1) Start a new game or\n\t2) Load a previous save\n Otherwise quit by entering q."
    response = user_option
    case response
    when '1'
      play_game
    when '2'
      play_game('load')
    when 'q'
      outro
    end
  end

  def play_game(type = '')
    load_old if type == 'load'
    loop do
      Hangman.new unless type == 'load'
      puts 'Continue playing a new game? Anything other than \'y\' quits the game'
      continue = gets.chomp.downcase
      break unless continue == 'y'

      type = ''
    end
    outro
  end

  def load_old
    puts 'What is the name you used last time?'
    fname = gets.chomp.downcase + '.json'
    return Hangman.new(true, fname) if File.exist? fname

    invalid_fname
  end

  def invalid_fname
    fname = '-1'
    loop do
      puts 'Enter a valid file name. Entering nothing will start a new game.'
      fname = gets.chomp
      break if File.exist?(fname) || fname.empty?
    end
    return if fname.empty?

    fname
  end

  def invalid_response
    response = ''
    loop do
      puts 'Please ensure you enter either 1, 2 or q'
      response = gets.chomp
      break if %w[1 2 q].include? response
    end
    response
  end

  def outro
    puts "Thank you for playing \e[1mHangman\e[0m!"
  end
end
Main.new
