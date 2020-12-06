# frozen-string-literal: true

# Module for displaying information/data
module Display
  def message_colour(type, value)
    colour_hash = {
      '_correct' => "\e[92m#{value}\e[0m",
      '_incorrect' => "\e[31m#{value}\e[0m",
      '_invalid' => "\e[33m#{value}\e[0m",
      '_serialise' => "\e[38;5;222m#{value}\e[0m..."
    }[type]
  end

  # Just thought I'd make it 'interesting', really
  def process_messages(type)
    message_hash = {
      '_correct' => [
        'Correct!',
        'That\'s right',
        'Nice, good choice!',
        'A fine letter you picked',
        'Thumbs up from me'
      ],
      '_incorrect' => [
        'Not quite the right guess...',
        'Getting closer... I hope anyway',
        'Nope, not what I\'m looking for',
        'A compeltely different letter would have done the trick.'
      ],
      '_invalid' => [
        'That guess is simply unacceptable! Humph.',
        'Ensure you\'re typing unused letters only or save',
        'Input invalid. Beep boop.',
        'Executioner: invalid input huh... this player isn\'t takin\' us seriously. Best sort \'im out.'
      ],
      '_serialise' => ['Serialising...', 'Saving...', 'Committing your performance to memory!']
    }
    to_print = message_hash[type].sample
    message_colour(type, to_print)
  end

  def display_intro
    puts "To save the game enter 'save'\nTo exit enter 'exit'.\nAbove all else remember: this is \e[1mHangman\e[0m. So. Don't. Get. Hanged."
    puts
  end

  def display_array(secret_word_array)
    puts "#{secret_word_array.join ''}\n"
    puts
  end

  def display_mistakes_left(mistakes_left)
    return puts "You have \e[34m#{mistakes_left}\e[0m guess left" if mistakes_left == 1

    puts "You have \e[34m#{mistakes_left}\e[0m guesses left"
  end

  def display_guesses(guesses)
    puts "These have been your previous guesses: #{guesses.join ' '}"
  end

  def display_guess_msg
    print 'Enter a letter to decipher the secret word: '
  end

  def display_feedback(key)
    puts process_messages(key)
  end

  def display_output(key, guesses, mistakes_left, secret_word_array)
    display_intro
    display_array(secret_word_array)
    display_mistakes_left(mistakes_left)
    display_guesses(guesses)
    display_feedback(key) unless key.nil?
  end
end
