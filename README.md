# Hangman and Serialisation
This is code for a simple [Hangman](http://en.wikipedia.org/wiki/Hangman_(game)) game, with an additional feature that allows saving the game. 

## Aim and Rules
Hangman is a word-guessing game where a player, or players, try and determine a word chosen by their opponent letter by letter. In order for it to be interesting you have a limited number of incorrect guesses. When this reaches zero you are figuratively hanged (yes, figuratively -- technology has not gone that far... *yet*). Typically a stick figure is drawn part by part as each mistake is made, which will depict your grim fate upon your failure.

## Tasks
Okay, dramatic explanation aside, it's time to explain how this project *extends* hangman. Since I am learning to apply **serilisation**, this hangman game will have a save feature. In other words, the object representing the state of the game will be saved to a file as a string. So, the tasks are that the game:
- [x] Picks a random word between 5 and 12 letters long
- [x] Penalise incorrect guesses
- [x] Allow the user to save the game
- [x] (Optional) Add colour
- [] (Optional) Add instructions

## Resources
Other than the colouring for bash output as found in [Mastermind](https://github.com/qamk/mastermind-top), there weren't many notable resources. One notable thing is:
- The [send method](https://stackoverflow.com/questions/35400337/ruby-send-vs-call-method).
  - [The documentation](https://ruby-doc.org/core-2.7.2/Object.html#method-i-send), of course, has a good description.