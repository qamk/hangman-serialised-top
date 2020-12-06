# frozen-string-literal: true

# Simple player class
class Player
  attr_reader :name
  def initialize(existing_name = nil)
    @name = existing_name.nil? ? greetings : existing_name
  end

  def greetings
    puts 'Hi there! What is your name?'
    name = gets.chomp.downcase
    name.empty? ? invalid_name : name
  end

  def invalid_name
    name = ''
    loop do
      puts 'Please ensure you enter some text.'
      name = gets.chomp
      break unless name.empty?
    end
    name
  end
end
