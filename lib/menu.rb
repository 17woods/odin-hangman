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
      else
        next
      end
    end
  end

  public

  def save_game
    @save_index = 1

    loop do
      if Dir['./saves/*'].include?("./saves/#{@save_index}.txt")
        @save_index += 1
        next
      end

      break
    end

    @save_file = File.open("./saves/#{@save_index}.txt", 'w+')

    @save_file.puts "stage=#{@stage},num_o_guesses=#{@num_o_guesses}," +
    "revealed_letters=#{@revealed_letters}," +
    "guessed_letters=#{@guessed_letters}," +
    "secret_word=#{@secret_word}"

    puts "Game saved to #{@save_file.path}"

    @save_file.close

    exit
  end

  def load_menu
    loop do
      puts "\nLoad Menu\nAvailable saves:"
      puts "#{Dir['./saves/*']}"
      puts "Enter the index of your desired save or 0 to go back"

      @load_input = gets.chomp

      break if @load_input == '0'

      unless Dir['./saves/*'].include?("./saves/#{@load_input}.txt")
        next
      end

      @loaded_file = File.open("./saves/#{@load_input}.txt", 'r')
      @file_data = @loaded_file.read

      @l_stage = Integer(/\d/.match(/stage=\d/.match(@file_data).to_s).to_s)
      @l_num = Integer(/\d/.match(/num_o_guesses=\d/.match(@file_data).to_s).to_s)
      @l_revealed = JSON.parse /{.+}/.match(@file_data).to_s.gsub('=>', ':')
      @l_guessed = JSON.parse /\[.+\]/.match(@file_data).to_s
      @l_secret = /\w+$/.match(@file_data).to_s
      
      break
    end
    game = Game.new(@l_secret, @l_revealed, @l_guessed, @l_num, @l_stage, @load_input)
    game.play
  end
end
