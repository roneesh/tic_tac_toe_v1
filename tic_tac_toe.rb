# BOARD LOGIC

def draw_board
  
  9.times do |i|
    if @X.include?(i+1)
      @BOARD[i] = "X"
    elsif @O.include?(i+1)
      @BOARD[i] = "O"
    else
      @BOARD[i] = "_"
    end
  end

  puts "#{@BOARD[0]}|#{@BOARD[1]}|#{@BOARD[2]}"
  puts "#{@BOARD[3]}|#{@BOARD[4]}|#{@BOARD[5]}"
  puts "#{@BOARD[6]}|#{@BOARD[7]}|#{@BOARD[8]}"
  puts ""


end


# MERCILESS AI

def would_win?(possible_winning_array)
  @WIN_LIST.each do |win_combo|
    if possible_winning_array.include?(win_combo[0]) && possible_winning_array.include?(win_combo[1]) && possible_winning_array.include?(win_combo[2])
      return true
    end
  end
end

def the_smart_move(player_array)
  possible_moves = [1,2,3,4,5,6,7,8,9]
  available_moves = possible_moves - @X - @O
  print "compy is choosing from: #{available_moves}"
  puts ""
  best_move = 0

  #The case where a move will cause a win
  available_moves.each do |available_move|
    possible_winning_array = player_array
    possible_winning_array << available_move
    if would_win?(possible_winning_array)
      puts "possible winning array is: #{possible_winning_array}"
      best_move = available_move
      puts "there's a winning move! move = #{move}"
    end
  end

  #The case where a move would prevent losing the next round
    # 1. Capture the array that's not the player array
  # opponents_array = []
  #   if player_array == @X
  #     opponents_array = @O
  #   else opponents_array = @X
  #   end

    # 2. Run oppoents array through logic of if a move would cause a win
    # available_moves.each do |available_move|
    #   possible_winning_array = opponents_array << available_move
    #   if would_win?(possible_winning_array)
    #     puts "blocked ya sucker!"
    #     break available_move
    #   end
    # end

  # The case where the center is open
  # available_moves.each do |available_move|
  #   if available_move == 5
  #     puts "center knows best!"
  #     move = available_move
  #   end
  # end

  # if move == 0
  # move == rand(1..9)
  # end

  # puts "the final move is: #{move}"
  return best_move

end


# GAME LOGIC

def game_initialize
  @WIN_LIST = [ [1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [7,5,3] ]
  @X = []
  @O = []
  @TAKEN_MOVES = (@X + @O).sort
  @BOARD = []

  puts "Welcome to Tic Tac Whoa!"
  puts "Do you want to go first(play as X) or second(play as O)? ('X' - First, Other keys - Second)"
  decision = gets.chomp
  puts ""
  if decision == "X"
    puts "You are playing as X"
    puts ""
    human_as_x
  else
    puts "You are playing as O"
    puts ""
    compy_as_x
  end 
end

def winner?
  @WIN_LIST.each do |win_combo|
    if @X.include?(win_combo[0]) && @X.include?(win_combo[1]) && @X.include?(win_combo[2])
      puts "X wins!"
      return true
    end
    if @O.include?(win_combo[0]) && @O.include?(win_combo[1]) && @O.include?(win_combo[2])
      puts "O wins!"
      return true
    end
  end
  return false
end

def board_full?
  taken_moves = @X + @O
  if taken_moves.sort == [1,2,3,4,5,6,7,9]
    puts "It's a CAT game!"
    return true
  else 
    return false
  end
end

def valid?(move)
  if move.class != Fixnum || move > 9 || move < 1 || @X.include?(move) || @O.include?(move)
    return false
  else
    return true
  end
end

def human_move(player_array)
  puts "Choose a spot(1-9)"
  move = gets.chomp.to_i
  until valid?(move)
    puts "(Move not valid!) Choose a spot"
    move = gets.chomp.to_i
  end
  player_array << move.to_i
  @TAKEN_MOVES << move.to_i
end

def computer_move(player_array)
  puts "And the computer selects..."
  # move = the_smart_move(player_array)
  move = minimax
  player_array << move
  @TAKEN_MOVES << move
end

def human_as_x
  until winner? || board_full?
    human_move(@X)
    draw_board
    computer_move(@O)
    draw_board
  end
end

def compy_as_x
  until winner? || board_full?
    computer_move(@X)
    draw_board
    human_move(@O)
    draw_board
  end
end

game_initialize


















