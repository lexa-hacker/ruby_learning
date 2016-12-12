class User
	def initialize(attributes)
		@login = attributes[:login]
		@password = attributes[:password]
	end

	attr_accessor :login, :password
end