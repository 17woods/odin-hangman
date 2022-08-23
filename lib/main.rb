require './lib/hangedmen.rb'

module WordList
  attr_reader :word_list

  @@word_list = Array.new

  @@file = File.open('word_list.txt', 'r').each do |line|
    if line.chomp.length.between?(5, 12)
      @@word_list.push(line.chomp)
    end
  end
end

class Game
  attr_reader :secret_word
  attr_reader :display_string
  attr_reader :revealed_letters
  attr_reader :hangman
  attr_accessor :stage

  include WordList
  include HangedMen

  def initialize
    @secret_word = @@word_list.sample

    @revealed_letters = Hash.new
    @guessed_letters = Array.new
    @num_o_guesses = 0
    @stage = 0

    @secret_word.each_char do |char|
      @revealed_letters[char] = "_"
    end

    refresh_display
  end

  private

  def refresh_display
    @display_string = ''

    @secret_word.each_char do |char|
      @display_string += "#{@revealed_letters[char]}\s"
    end

    @display_string.strip!

    case @stage
    when 0
      @hangman = @@stage_0
    when 1
      @hangman = @@stage_1
    when 2
      @hangman = @@stage_2
    when 3
      @hangman = @@stage_3
    when 4
      @hangman = @@stage_4
    when 5
      @hangman = @@stage_5
    when 6
      @hangman = @@stage_6
    end
  end

  public

  def check_guess(char)
    @guessed_letters.push(char)

    @num_o_guesses += 1

    if @revealed_letters[char] == "_"
      @revealed_letters[char] = char 
    else
      @stage += 1
    end

    refresh_display
  end
end

game = Game.new

p game.secret_word

game.check_guess("e")
p game.display_string, game.revealed_letters

puts game.hangman
6.times do
  game.check_guess("e")
  puts game.hangman
end
