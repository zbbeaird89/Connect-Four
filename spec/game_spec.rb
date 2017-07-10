require "spec_helper"

module ConnectFour
	describe Game do 

		FakePlayer = Struct.new(:name, :symbol)
		let(:zach) { FakePlayer.new({:name => "Zach", :symbol => "X"}) }
		let(:sky)  { FakePlayer.new({:name => "Sky", :symbol => "O"}) }

		describe "#initialize" do 
			it "raises exception if not given any arguments" do 
				expect { Game.new }.to raise_error(ArgumentError)
			end

			it "raises exception if not given 2 players" do 
				board = double("board")
				message = "Must have 2 Players"
				expect { Game.new(board, zach) }.to raise_error(message)
			end
		end

		describe "#board" do 
			it "reads the board" do 
				board = double("board")
				allow(board).to receive(:grid).and_return("grid")
				game = Game.new(board, [zach, sky])
				expect(game.board.grid).to eq "grid"
			end
		end

		describe "#current_player" do 
			it "returns the current_player" do 
				board = double("board")
				game = Game.new(board, [zach, sky])
				expect(game.current_player).to eq zach
			end

			it "can change current_player" do 
				board = double("board")
				game = Game.new(board, [zach, sky])
				game.current_player = sky
				expect(game.current_player).to eq sky
			end
		end

		describe "#other_player" do 
			it "returns the other_player" do 
				board = double("board")
				game = Game.new(board, [zach, sky])
				expect(game.other_player).to eq sky
			end

			it "can change other_player" do 
				board = double("board")
				game = Game.new(board, [zach, sky])
				game.other_player = zach
				expect(game.other_player).to eq zach
			end
		end

		describe "#switch_players" do 
			it "switches current_player to other_player" do 
				board = double("board")
				game = Game.new(board, [zach, sky])
				game.switch_players
				expect(game.current_player).to eq sky
			end

			it "switches other_player to current_player" do 
				board = double("board")
				game = Game.new(board, [zach, sky])
				game.switch_players
				expect(game.other_player).to eq zach
			end
		end
	end
end