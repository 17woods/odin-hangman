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

  include WordList

  def initialize
    @secret_word = @@word_list.sample
    
    @revealed_letters = Hash.new
    @display_string = String.new

    @secret_word.each_char do |char|
      @revealed_letters[char] = "_"
      @display_string += "#{@revealed_letters[char]}\s"
    end

    @display_string.strip!
  end
end

# for each letter i must add a reference to it's value in the hash

game = Game.new
p game.secret_word
p game.display_string
