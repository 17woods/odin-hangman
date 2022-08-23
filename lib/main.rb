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

  include WordList
  include HangedMen

  def initialize
    @secret_word = @@word_list.sample.upcase

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

  def win_ner
    puts "Congradulations! You won!"
    puts "You got the answer in #{@num_o_guesses} guesses!"
    play_again?
  end

  def lo_ser
    puts "Haha! You lost!"
    puts "You are too stupid to guess the word #{@secret_word}"
    puts "dumbass lol"
    play_again?
  end

  def play_again?
    puts "\nDo you want to play again? (y/n)"
    @yes_or_no = gets.chomp.downcase.strip

    exit if @yes_or_no != 'y'

    initialize
    play
  end

  public

  def play
    until @stage == 6 || !@revealed_letters.values.include?('_') do
      puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
      puts @hangman, @display_string
      puts "Guessed Letters: #{@guessed_letters.join(', ')}"

      @input = gets.chomp.upcase

      win_ner if @input == @secret_word

      next if @input.length != 1
      next if @guessed_letters.include?(@input)
      
      check_guess(@input)
    end

    lo_ser if @stage == 6
    win_ner unless @revealed_letters.include?('_')
    puts "E0"
  end
end

game = Game.new

p game.secret_word

game.play
