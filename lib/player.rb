# frozen-string-literal: true

# Simple player class
class Player
  attr_reader :name
  def initialize
    @name = greetings
  end

  def greetings
    puts 'Welcome! What is your name?'
    gets.chomp.downcase
  end
end
