require "spec_helper"
require "pry"

module ConnectFour
	describe Board do 

		let(:empty) { Slot.new("_") }
		let(:x) 		{ Slot.new("X") }
		let(:o)			{ Slot.new("O") }
		let(:grid)  { [[empty, empty, empty], 
									 [empty, empty, empty], 
									 [empty, empty, empty]] }

		describe "#initialize" do 
			context "when given an argument" do 
				it "accepts a grid that has nested arrays" do  
					board = Board.new(:grid => grid)
					expect { board }.to_not raise_error
				end
			end	

			context "when not given an argument" do 
				it "creates a grid by default" do 
					expect { Board.new }.to_not raise_error
				end
			end
		end

		describe "#grid" do 
			context "by default" do 
				it "has 6 rows" do 
					board = Board.new
					expect(board.grid.length).to eq 6
				end

				it "has 7 columns" do 
					board = Board.new
					board.grid.each do |row|
						expect(row.length).to eq 7
					end
				end

				it "can read the grid" do 
					board = Board.new(:grid => grid)
					expect(board.grid).to eq grid
				end
			end
		end

		describe "#columns_and_slots" do 
			it "can read the variable" do 
				board = Board.new
				expect { board.columns_and_slots }.to_not raise_error
			end

			context "with default grid" do 
				it "has 7 columns" do 
					board = Board.new
					expect(board.columns_and_slots.keys.length).to eq 7
				end

				it "has 6 slots to each column" do 
					board = Board.new
					board.columns_and_slots.each do |column, slots|
						expect(slots.length).to eq 6
					end
				end
			end

			it "allows a slot to be removed" do 
				board = Board.new
				board.columns_and_slots["1"].pop
				expect(board.columns_and_slots["1"].length).to eq 5
			end
		end
		
		describe "#fill_slot" do 
			context "when given a slot with a value" do 
				it "updates slot's value" do 
					board = Board.new
					board.fill_slot(empty, "X") 
					expect(empty.value).to eq "X"
				end

				it "updates the grid" do 
					board = Board.new(:grid => grid)
					selected_slot = board.columns_and_slots["1"].pop
					board.fill_slot(selected_slot, "X")
					expect(board.grid[2][0].value).to eq "X"
				end
			end
		end

		describe "#drop_disc" do 
			context "when given a column number and player's symbol" do 
				it "fills that column's last slot with symbol" do 
					board = Board.new(:grid => grid)
					symbol = "X"
					board.drop_disc("1", "X")
					expect(board.grid[2][0].value).to eq "X"
				end
			end
		end

		describe "#winner?" do  
			context "backward line" do 
				context "when given a slot" do
					it "returns true for 3 of same value" do 
						grid = [[empty, empty, empty, empty, empty, empty, empty],
									  [empty, empty, empty, empty, empty, empty, empty],
										[x, empty, empty, empty, empty, empty, empty],
									  [o, x, empty, empty, empty, empty, empty],
									  [o, o, Slot.new("X"), empty, empty, empty, empty],
									  [o, x, o, x, empty, empty, empty]]
						board = Board.new(:grid => grid)
						board.last_slot_filled = board.grid[4][2]
						expect(board.winner?).to eq true
					end

					it "returns false if not 3 of same value" do 
						grid = [[empty, empty, empty, empty, empty, empty, empty],
									  [empty, empty, empty, empty, empty, empty, empty],
										[x, empty, empty, empty, empty, empty, empty],
									  [o, x, empty, empty, empty, empty, empty],
									  [o, o, Slot.new("X"), empty, empty, empty, empty],
									  [o, x, o, o, empty, empty, empty]]
						board = Board.new(:grid => grid)
						board.last_slot_filled = board.grid[4][2]
						expect(board.winner?).to eq false
					end
				end
			end

			context "forward line" do 
				context "when given a slot" do 
					it "returns true for 3 of same value" do 
						grid = [[empty, empty, empty, empty, empty, empty, empty],
									  [empty, empty, empty, empty, empty, empty, empty],
										[x, empty, empty, empty, x, empty, empty],
									  [o, x, empty, x, empty, empty, empty],
									  [o, o, Slot.new("X"), empty, empty, empty, empty],
									  [o, x, o, o, empty, empty, empty]]
						board = Board.new(:grid => grid)
						board.last_slot_filled = board.grid[4][2]
						expect(board.winner?).to eq true
					end

					it "returns false if not 3 of same value" do 
						grid = [[empty, empty, empty, empty, empty, empty, empty],
									  [empty, empty, empty, empty, empty, empty, empty],
										[x, empty, empty, empty, o, empty, empty],
									  [o, x, empty, x, empty, empty, empty],
									  [o, o, Slot.new("X"), empty, empty, empty, empty],
									  [o, x, o, o, empty, empty, empty]]
						board = Board.new(:grid => grid)
						board.last_slot_filled = board.grid[4][2]
						expect(board.winner?).to eq false
					end
				end
			end

			context "vertical line" do 
				context "when given a slot" do 
					it "returns true for 3 of same value" do 
						grid = [[empty, empty, empty, empty, empty, empty, empty],
									  [empty, empty, empty, empty, empty, empty, empty],
										[x, empty, Slot.new("X"), empty, o, empty, empty],
									  [o, x, x, x, empty, empty, empty],
									  [o, o, x, empty, empty, empty, empty],
									  [o, x, x, o, empty, empty, empty]]
						board = Board.new(:grid => grid)
						board.last_slot_filled = board.grid[2][2]
						expect(board.winner?).to eq true
					end

					it "returns false if not 3 of same value" do 
						grid = [[empty, empty, empty, empty, empty, empty, empty],
									  [empty, empty, empty, empty, empty, empty, empty],
										[x, empty, empty, empty, o, empty, empty],
									  [o, x, Slot.new("X"), x, empty, empty, empty],
									  [o, o, x, empty, empty, empty, empty],
									  [o, x, x, o, empty, empty, empty]]
						board = Board.new(:grid => grid)
						board.last_slot_filled = board.grid[3][2]
						expect(board.winner?).to eq false
					end
				end
			end

			context "horizontal line" do 
				context "when given a slot" do 
					it "returns true for 3 of same value" do 
						grid = [[empty, empty, empty, empty, empty, empty, empty],
									  [empty, empty, empty, empty, empty, empty, empty],
										[x, empty, empty, empty, o, empty, empty],
									  [o, x, Slot.new("X"), x, x, empty, empty],
									  [o, o, x, empty, empty, empty, empty],
									  [o, x, x, o, empty, empty, empty]]
						board = Board.new(:grid => grid)
						board.last_slot_filled = board.grid[3][2]
						expect(board.winner?).to eq true
					end

					it "returns false if not 3 of same value" do 
						grid = [[empty, empty, empty, empty, empty, empty, empty],
									  [empty, empty, empty, empty, empty, empty, empty],
										[x, empty, empty, empty, o, empty, empty],
									  [o, x, Slot.new("X"), x, o, empty, empty],
									  [o, o, x, empty, empty, empty, empty],
									  [o, x, x, o, empty, empty, empty]]
						board = Board.new(:grid => grid)
						board.last_slot_filled = board.grid[3][2]
						expect(board.winner?).to eq false
					end
				end
			end
		end

		describe "#draw?" do 
			it "returns true when all slots are taken" do 
				board = Board.new(:grid => grid)
				board.columns_and_slots.each do |col, row|
					board.columns_and_slots[col] = []
				end
				expect(board.draw?).to eq true
			end
		end

		describe "#game_over" do 
			context "when there is a winner" do 
				it "returns :winner" do 
					board = Board.new(:grid => grid)
					allow(board).to receive(:winner?).and_return(true)
					expect(board.game_over).to eq :winner
				end
			end

			context "when there is a draw" do 
				it "returns :draw" do 
					board = Board.new(:grid => grid)
					allow(board).to receive(:winner?).and_return(false)
					allow(board).to receive(:draw?).and_return(true)
					expect(board.game_over).to eq :draw
				end
			end
		end
	end
end