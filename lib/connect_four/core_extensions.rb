class Range
	def each
		if self.first < self.last
			self.to_s=~(/\.\.\./) ? last = self.last - 1 : last = self.last
			self.first.upto(last) { |i| yield i }
		else
			self.to_s=~(/\.\.\./) ? last = self.last + 1 : last = self.last
			self.first.downto(last) { |i| yield i }
		end
	end
end
