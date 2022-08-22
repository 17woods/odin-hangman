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

  include WordList

  def initialize
    @secret_word = @@word_list.sample
  end
end

game = Game.new
p game.secret_word
