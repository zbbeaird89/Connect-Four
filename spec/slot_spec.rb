require "spec_helper"

module ConnectFour
	describe Slot do 
		describe "#initialize" do 
			it "has a value of '__' by default" do 
				slot = Slot.new
				expect(slot.value).to eq "_"
			end

			it "accepts an argument" do 
				slot = Slot.new("Z")
				expect(slot.value).to eq "Z"
			end
		end

		describe "#setter" do 
			it "updates value" do 
				slot = Slot.new("Z")
				slot.value = "B"
				expect(slot.value).to eq "B"
			end
		end
	end
end