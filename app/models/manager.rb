class Manager < User
	validates :salary,     numericality: { equal_to: 10000} 
	def new
		@manager=Manager.new
	end
end
