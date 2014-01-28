require 'rubygems'
require 'ruby-standard-deviation'
class MovieTest
	attr_accessor :ratings, :predictions, :differences
	def initialize(rating, prediction)
		@ratings = []
		@predictions = []
		@differences = []

		@ratings << rating
		@predictions << prediction
	end

	def add (rating, prediction)
		@ratings << rating
		@predictions << prediction
	end

	def mean()
		count = 0
		ratings.each do |rating|
			@differences << (rating.rating - predictions[count]).abs
			count += 1
		end
		@differences.inject(0.0) { |sum, el| sum + el } / @differences.size
	end

	def stddev
		@differences.stdev
	end

	def rms
		Math.sqrt(@differences.inject(0.0) { |sum, e1| sum + e1**2} / @differences.size)
	end

	def to_a
		result = []
		count = 0
		@ratings.each do |rating|
			result << rating.user_id
			result << rating.movie_id
			result << rating.rating
			result << @predictions[count]
			count +=1
		end
	end

end