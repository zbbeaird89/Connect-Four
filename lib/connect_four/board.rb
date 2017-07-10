module ConnectFour
	class Board
		attr_reader :grid
		attr_accessor :columns_and_slots, :last_slot_filled

		def initialize(input = {})
			@grid = input.fetch(:grid, default_grid)
			@columns_and_slots = link_columns_and_slots(@grid)
		end

		def drop_disc(column, symbol)
			@last_slot_filled  = @columns_and_slots[column].pop
			fill_slot(@last_slot_filled, symbol)
		end

		def fill_slot(slot, value)
			slot.value = value
		end

		def game_over 
			return :winner if winner?
			return :draw if draw?
		end

		def winner?
			slot = @last_slot_filled
			x, y = slot_position(slot) 
			symbol = slot.value
			slot_lines = {
				:backward_line   => count_diagonal((x - 1..x - 3), (y - 1..y - 3), slot) +
													  count_diagonal((x + 1..x + 3), (y + 1..y + 3), slot),
	      :forward_line    => count_diagonal((x - 1..x - 3), (y + 1..y + 3), slot) +
	      								    count_diagonal((x + 1..x + 3), (y - 1..y - 3), slot),
        :vertical_line   => count_vertical((x + 1..x + 3), y, slot),
        :horizontal_line => count_horizontal(x, (y + 1..y + 3), slot) +
        										count_horizontal(x, (y - 1..y - 3), slot)
			} 
			return true if slot_lines.any? { |line, slots| slots >= 3 }
			return false
		end

		def draw?
			columns_and_slots.all? { |col, row| row.empty? }
		end

		private

		def default_grid
			Array.new(6) { Array.new(7) { Slot.new } }
		end

		def link_columns_and_slots(grid)
			links = {}
			grid.transpose.each_with_index do |column, i|
				links[(i + 1).to_s] = column
			end
			return links
		end

		def slot_position(slot)
			@grid.each_index do |i|
				j = @grid[i].index(slot)
				return [i, j] unless j.nil?
			end
		end

		#xs and ys will both be ranges
		#xs represent the rows and ys represent objects in those rows
		#counts how many objects match slot.value 
		def count_horizontal(x, ys, slot) 
			count = 0

			ys.each do |num|
				#Checks that we don't go off of the board and that we
				#stop checking if the value does'nt match slot's value
				if num < 0 || num > 5 || x < 0 || x > 6 || 
				@grid[x][num].nil? || @grid[x][num].value != slot.value
					break
				elsif @grid[x][num].value == slot.value
					count += 1
				end
			end

			return count
		end

		def count_vertical(xs, y, slot)
			count = 0

			xs.each do |num|
				#Checks that we don't go off of the board and that we
				#stop checking if the value does'nt match slot's value
				if num < 0 || num > 5 || y < 0 || y > 6 || 
				@grid[num][y].nil? || @grid[num][y].value != slot.value
					break
				elsif @grid[num][y].value == slot.value
					count += 1
				end
			end

			return count
		end

		def count_diagonal(xs, ys, slot)
			count = 0

			xs.each_with_index do |num, i|

				y = ys.to_a[i]
				
				#Checks that we don't go off of the board and that we
				#stop checking if the value does'nt match slot's value
				if num < 0 || num > 5 || y < 0 || y > 6 || 
				@grid[num][y].nil? || @grid[num][y].value != slot.value
					break
				elsif @grid[num][y].value == slot.value
					count += 1
				end
			end

			return count
		end

	
	end
end