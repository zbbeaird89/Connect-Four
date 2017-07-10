module ConnectFour
	class Player
		attr_reader :name, :symbol
		def initialize(input = {})
			@name   = input.fetch(:name)
			@symbol = input.fetch(:symbol)
		end
	end
end