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

  include WordList

  def initialize
    @secret_word = @@word_list.sample

    @revealed_letters = Hash.new
    @display_string = String.new
    @guessed_letters = Array.new
    @num_o_guesses = 0

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
  end

  public

  def check_guess(char)
    @guessed_letters.push(char)

    @num_o_guesses += 1

    @revealed_letters[char] = char if @revealed_letters[char] == "_"

    refresh_display
  end
end

game = Game.new

p game.secret_word
p game.display_string
p game.revealed_letters

game.check_guess("e")
p game.display_string, game.revealed_letters
