# frozen-string-literal: true

require_relative 'lib/mechanics.rb'
require_relative 'lib/player.rb'
require_relative 'lib/display.rb'

# Class for the main game
class Hangman
  include Display
  include Mechanics
  attr_reader :secret_word, :player, :secret_word_array, :mistakes_left, :guess, :guesses, :method_hash
  def initialize
    @player = Player.new
    @secret_word = select_word
    @secret_word_array = secret_word.split('').map { '_' }
    @mistakes_left = 10
    @guesses = []
    play
  end

  def play
    key = nil
    loop do
      system('clear')
      display_elements(key)
      break if mistakes_left.zero? || secret_word_array.join == select_word || key == '_serialise'

      validate_guess
      key = process_guess(guess, secret_word)
      call_me(key, process_method_hash(key))
      @mistakes_left -= 1 if key == '_incorrect'
    end
  end

  def validate_guess
    loop do
      display_guess_msg
      @guess = gets.chomp.downcase
      break if valid_guess?(guess, guesses)

      display_feedback('_invalid')
    end
  end

  private

  def display_elements(key)
    display_output(key, guesses, mistakes_left, secret_word_array)
  end

  def process_method_hash(key)
    method_hash = {
      '_correct' => [guess, secret_word_array, @secret_word, guesses],
      '_incorrect' => [guess, guesses],
      '_serialise' => self
    }
    method_hash[key]
  end
end
Hangman.new
