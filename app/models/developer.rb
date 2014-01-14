class Developer < User
	validates :salary,     numericality: { equal_to: 1000} 
	def new
		@developer=Developer.new
	end
end