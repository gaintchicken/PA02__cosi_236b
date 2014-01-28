class User
	attr_accessor :movies_watched
	def initialize movie, rating
		@movies_watched = Hash.new()
		add_rating movie, rating

	end
	def add_rating movie, rating
		@movies_watched[movie] = rating
	end
	def get_rating movie
		result = 0
		result = @movies_watched[movie] unless @movies_watched[movie].nil?
		result
	end

	def movie_list
		@movies_watched.keys
	end
end