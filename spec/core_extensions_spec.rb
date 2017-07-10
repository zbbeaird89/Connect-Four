require "spec_helper"

describe Range do 
	describe "#each" do 
		context "when range is descending" do 
			it "iterates down" do 
				range = (0..-5)
				output = []
				range.each { |i| output << i }
				expect(output).to eq [0, -1, -2, -3, -4, -5]
			end

			it "'...' excludes last value" do 
				range = (0...-5)
				output = []
				range.each { |i| output << i }
				expect(output).to eq [0, -1, -2, -3, -4]
			end
		end

		context "when range is ascending" do 
			it "iterates up" do 
				range = (0..5)
				output = []
				range.each { |i| output << i }
				expect(output).to eq [0, 1, 2, 3, 4, 5]
			end

			it "'...' excludes last value" do 
				range = (0...5)
				output = []
				range.each { |i| output << i }
				expect(output).to eq [0, 1, 2, 3, 4]
			end
		end
	end
end