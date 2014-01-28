class Rating
	attr_accessor :user_id, :movie_id, :rating
	def initialize(user_id, movie_id, rating)
		@user_id = user_id
		@movie_id = movie_id
		@rating = rating
	end
end