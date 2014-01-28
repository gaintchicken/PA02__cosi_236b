class Movie
	attr_accessor :users_rated, :avg_rating, :tot_rating
	def initialize (user_id, rating)
		@tot_rating = 0
		@num_ratings = 0
		@avg_rating = 0
		@users_rated = Array.new(user_id)
		calc_average(rating)
	end
	def add_rating (user_id, rating)
		@users_rated << user_id
		calc_average(rating)
	end
	private
	def calc_average (rating)
		@tot_rating += rating
		@num_ratings += 1
		@avg_rating = tot_rating/ @num_ratings
		@avg_rating
	end
end