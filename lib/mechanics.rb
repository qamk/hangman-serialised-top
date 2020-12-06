# frozen-string-literal: true

require 'json'

# Module for the hangman game
module Mechanics
  def select_word
    secret_word = ''
    File.open('5desk.txt') do |file|
      word_list = file.readlines.map(&:chomp).filter { |word| word.length.between?(5, 12) }
      secret_word = word_list.sample
    end
    secret_word
  end

  def call_me(key, args)
    processes_hash = {
      '_serialise' => 'serialise', # save function
      '_correct' => 'correct',
      '_incorrect' => 'incorrect'
    }
    send(processes_hash[key], *args)
  end

  def process_guess(guess, secret_word)
    return '_serialise' if guess.downcase == 'save'

    return '_correct' if secret_word.downcase.include? guess

    '_incorrect'
  end

  def valid_guess?(guess, guesses)
    return true if %w[save exit].include? guess

    return false if guess.length != 1 || guesses.include?(guess)

    guess =~ /[^a-zA-z]/ ? false : true
  end

  private

  def correct(guess, secret_word_array, secret_word, guesses)
    secret_word_clone = secret_word.downcase.clone
    while secret_word_clone.include? guess
      index = secret_word_clone.index guess
      secret_word_array[index] = guess
      secret_word_clone[index] = '*'
    end
    guesses.append(guess)
  end

  def incorrect(guess, guesses)
    guesses.append(guess)
  end

  def serialise(obj)
    serialised_obj = JSON.dump(
      {
        player: obj.player.name,
        secret_word: obj.secret_word,
        secret_word_array: obj.secret_word_array,
        mistakes_left: obj.mistakes_left,
        guesses: obj.guesses
      }
    )
    File.open("#{obj.player.name}.json", 'w') { |file| file.puts serialised_obj }
  end

  def deserialise(fname)
    File.open(fname, 'r') { |file| JSON.load file }
  end
end
