class Lead < User
	validates :salary,     numericality: { equal_to: 5000} 
	def new
		@lead=Lead.new
	end
end