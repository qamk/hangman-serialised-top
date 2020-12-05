# frozen-string-literal: true

require 'yaml'

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
    return true if guess == 'save'

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
    fname = obj.player.name
    serialised_obj = YAML.dump(obj)
    File.open("#{fname}.yaml", 'w') { |file| file.puts serialised_obj }
  end
end
