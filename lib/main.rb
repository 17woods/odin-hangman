class Main
  attr_reader :word_list

  def initialize
    @word_list = File.read('word_list.txt').split('\n')
    @secret_word = 0
  end
end

game = Main.new
p game.word_list
