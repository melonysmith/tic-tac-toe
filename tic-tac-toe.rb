class TicTacToe
	@@player1 = "X"
	@@player2 = "O"

	def initialize
		@board = ('0'...'9').to_a
		@player1_go = true
	end

	def integer?(value)
		Integer(value) != nil rescue false
	end

	def display
		@out = ""
		@row = 0
		@board.each_with_index do |x, i|
			@out = @out + x
			if (i + 1) % 3 == 0
				puts @out
				if @row <= 1
					puts "---------"
					@row = @row + 1
				end
				@out = ""
			else
				@out = @out + " | "
			end
		end
	end

	def taken?(choice)
		@board[choice] == @@player1 || @board[choice] == @@player2
	end

	def update(choice, input)
		result = false
		if !taken?(choice)
			@board[choice] = input
			result = true
		end
		result
	end

	def row_pattern?(start, input)
		[@board[start], @board[start + 1], @board[start + 2]].all?{|word| word == input}
	end

	def column_pattern?(start, input)
		[@board[start], @board[start + 3], @board[start + 6]].all?{|word| word == input}
	end

	def diagonal_pattern?(start, input)
		result = false
		if start == 0
			result = [@board[start], @board[start + 4], @board[start + 8]].all?{|word| word == input}
		elsif start == 2
			result = [@board[start], @board[start + 2], @board[start + 4]].all?{|word| word == input}
		end
		result
	end

	def pattern_match?(input)
		row_pattern?(0, input) || row_pattern?(3, input) || row_pattern?(6, input) ||
		column_pattern?(0, input) || column_pattern?(1, input) || column_pattern?(2, input) ||
		diagonal_pattern?(0, input) || diagonal_pattern?(2, input)
	end

	def player_win?
		result = false
		if pattern_match?(@@player1)
			system "clear"
			puts "Player 1 is the winner!"
			result = true
		elsif pattern_match?(@@player2)
			system "clear"
			puts "Player 2 is the winner!"
			result = true
		end
		result
	end

	def draw?
		result = false
		if @board.all?{|item| item == @@player1 || item == @@player2}
			result = true
			puts "There is no winner. Please play again!"
		end
		result
	end

	def player_turn
		system "clear"
		display
		player_id = @player1_go ? '1' : '2'
		player_input = @player1_go ? @@player1 : @@player2
		begin
			print "Player #{player_id}'s turn ('#{player_input}'): "
			choice  = gets.chomp
			result = false
			if !integer?(choice)
				puts "Please use a number."
			elsif choice.to_i < 0 || choice.to_i > 8
				puts "Invalid. Please try again."
			else
				result = update(choice.to_i, player_input)
				if !result
					puts "Unavailable. Please try again."
				end
			end
		end until result == true
		@player1_go ^= true
	end

	def play
		while true
			player_turn
			break if player_win? || draw?
		end
		display
	end

	def run
		run = true
		display
		puts "Welcome to the game of Tic Tac Toe!"
		puts "Two players take turns placing tokens (X or O) on the board."
		puts "The first player to line up three tokens in a row vertically, horizontally, or diagonally wins."
		print "Press enter to begin!"
		gets.chomp
		begin
			initialize
			play
			print "Would you like to play again (type y for yes or n for no)?: "
			choice = gets.chomp
			if (choice == "n" || choice == "N")
				run = false
			end
		end until run == false
	end

end

game = TicTacToe.new
game.run
