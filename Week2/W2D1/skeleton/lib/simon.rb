class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over == true
      take_turn
    end

    system("clear")
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    unless @game_over == true
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    system("clear")

    @seq.each_with_index do |color, idx|
      puts "Color #{idx+1}: #{color}"
      sleep(1)
      system("clear")
    end
  end

  def require_sequence
    count = 0
    while count < @seq.length
      puts "Type out the color (red, blue, green, or yellow) and enter one at a time."
      print "Enter color ##{count+1}: "

      color = gets.chomp.downcase
      @game_over = true if color != @seq[count]
      break if @game_over == true
      count += 1
    end
  end

  def add_random_color
    @seq << COLORS[rand(0..3)]
  end

  def round_success_message
    puts "Congrats, you completed the round!"
  end

  def game_over_message
    puts "Bummer, incorrect sequence. Game over!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
