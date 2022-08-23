module Menu
  def main_menu
    loop do
      puts "1. New Game\n2. Load Game\n3. Exit"

      @input = Integer(gets.chomp)

      case @input
      when 1
        @game = Game.new
        @game.play
      when 2
        load_menu
      when 3
        exit
      end
    end
  end

  public

  def save_game
    @save_index = 0

    loop do
      p Dir['./saves/*'], Dir['./saves/*'].include?("./saves/#{@save_index}.txt")

      if Dir['./saves/*'].include?("./saves/#{@save_index}.txt")
        @save_index += 1
        next
      end

      break
    end

    @save_file = File.open("./saves/#{@save_index}.txt", 'w+')
    @save_file.puts "stage=#{@stage},num_o_guesses=#{@num_o_guesses}," +
    "revealed_letters=#{@revealed_letters}," +
    "guessed_letters=#{@guessed_letters}"
    @save_file.close
    exit
  end

  def load_menu
  end
end
