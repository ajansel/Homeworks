class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Board.populate
    @name1 = name1
    @name2 = name2
  end

  def self.populate
    cups = Array.new(14) {[:stone, :stone, :stone, :stone]}
    [6,13].each { |i| cups[i] = []}
    cups
  end

  # def place_stones
  #   # helper method to #initialize every non-store cup with four stones each
  # end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12
    raise "Invalid starting cup" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    moveable_stones = @cups[start_pos]
    @cups[start_pos] = []

    current_idx = start_pos

    until moveable_stones.empty?
      current_idx += 1
      current_idx = 0 if current_idx > 13

      if current_idx == 6
        @cups[6] << moveable_stones.pop if current_player_name == @name1
      elsif current_idx == 13
        @cups[13] << moveable_stones.pop if current_player_name == @name2
      else
        @cups[current_idx] << moveable_stones.pop
      end
    end

    render
    next_turn(current_idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].size == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    bool1 = (0..5).all? { |i| @cups[i].empty? }
    bool2 = (7..12).all? { |i| @cups[i].empty? }
    bool1 || bool2
  end

  def winner
    if @cups[6].size == @cups[13].size
      :draw
    elsif @cups[6].size > @cups[13].size
      @name1
    else
      @name2
    end

  end
end
