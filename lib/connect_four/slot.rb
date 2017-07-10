module ConnectFour
	class Slot
		attr_accessor :value
		def initialize(value = "_")
			@value = value
		end
	end
end