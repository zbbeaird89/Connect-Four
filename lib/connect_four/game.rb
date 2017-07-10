module ConnectFour
	class Game 
		attr_reader :board
		attr_accessor :current_player, :other_player

		def initialize(board, players)
			@board = board
			@players = players.is_a?(Array) ? players : [].push(players)

			raise "Must have 2 Players" unless @players.length == 2

			@current_player = @players.shift
			@other_player = @players.shift	
		end

		def switch_players
			@current_player, @other_player = @other_player, @current_player
		end

		def play
			solicit_move
			@board.drop_disc(gets.chomp, @current_player.symbol)

			if @board.game_over
				ending_message(@board.game_over) 
				return
			end

			switch_players
			play
		end

		def solicit_move
			output_board
			puts ""
			puts "It is #{@current_player.name}'s turn. Choose a column to drop a disc into."
		end

		def output_board
			(1..7).each { |num| print " #{num}" }
			puts ""
			@board.grid.each do |row|
				row.each_with_index do |slot, i|
					print "|#{slot.value}"
					print "|" if row[i + 1].nil?
				end
				puts ""
			end
		end

		def ending_message(outcome)
			output_board
			puts "The winner is #{@current_player.name}!" if outcome == :winner
			puts "The game ended in a draw." if outcome == :draw
		end
	end
end	