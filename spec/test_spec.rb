require_relative "./spec_helper"

module ConnectFour
	describe Test do 
		describe "#initialize" do 
			it "initializes new object" do 
				test = Test.new
				expect(test.value).to eq "Hello, World!"
			end
		end
	end
end