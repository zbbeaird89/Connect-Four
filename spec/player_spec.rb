require "spec_helper"

module ConnectFour
	describe Player do 
		describe "#initialize" do 
			context "when missing an argument" do 
				it "raises 'KeyError'" do  
					expect { Player.new(:name => "Zach") }.to raise_error(KeyError)
				end
			end

			context "when given correct arguments" do 
				it "passes without raising exception" do 
					arguments = { :name => "Zach", :symbol => "X"}
					expect { Player.new(arguments) }.to_not raise_error
				end
			end
		end

		describe "#name" do 
			it "reads the player's name" do 
				player = Player.new(:name => "Zach", :symbol => "X")
				expect(player.name).to eq "Zach"
			end

			it "raises error when trying to change name" do 
				player = Player.new(:name => "Zach", :symbol => "X")
				expect { player.name = "Lauren" }.to raise_error(NoMethodError)
			end
		end

		describe "#symbol" do 
			it "reads the player's symbol" do 
				player = Player.new(:name => "Zach", :symbol => "X")
				expect(player.symbol).to eq "X"
			end

			it "raises error when trying to change symbol" do 
				player = Player.new(:name => "Zach", :symbol => "X")
				expect { player.symbol = "O" }.to raise_error(NoMethodError)
			end
		end
	end
end