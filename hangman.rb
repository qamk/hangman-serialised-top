# frozen-string-literal: true

require_relative 'lib/mechanics.rb'
require_relative 'lib/player.rb'
require_relative 'lib/display.rb'

# Class for the main game
class Hangman
  include Display
  include Mechanics

  attr_reader :secret_word, :player, :secret_word_array, :mistakes_left, :guess, :guesses, :method_hash
  def initialize(load = false, fname = nil)
    load ? load_game(fname) : new_game
    play
  end

  def new_game
    @player = Player.new
    @secret_word = select_word
    @secret_word_array = secret_word.split('').map { '_' }
    @mistakes_left = 8
    @guesses = []
  end

  def load_game(fname)
    old_save = deserialise(fname)
    @player = Player.new(old_save['player'])
    @secret_word = old_save['secret_word']
    @secret_word_array = old_save['secret_word_array']
    @mistakes_left = old_save['mistakes_left']
    @guesses = old_save['guesses']
  end

  def play
    key = nil
    loop do
      system('clear')
      display_elements(key)
      break if mistakes_left.zero? || secret_word_array.join == select_word || key == '_serialise'

      validate_guess
      break if guess == 'exit'

      key = process_guess(guess, secret_word)
      call_me(key, process_method_hash(key))
      @mistakes_left -= 1 if key == '_incorrect'
    end
    puts "The secret word was \e[38;5;255m#{secret_word}\e[0m" if mistakes_left.zero?
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
