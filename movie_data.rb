#Author: Luka Milekic
class MovieData
	attr_accessor :movies, :most_popular, :users, :path_to_training, :name_of_test
	def initialize(location_training, location_test = nil )
		@movies = Hash.new(0)
		@users = Hash.new{|h,k| h[k] = [] }
		@most_popular = Array.new
		@path_to_training = location_training
		@name_of_test = location_test unless location_test.nil?
	end
	#loads data into an array, stores each rating as a Rating object
	def load_data
		File.open("u.data", "r").each_line do |line|
			a = line.split
			@movies[a[1].to_i] = @movies[a[1].to_i] + a[2].to_i

			@users[a[0].to_i] = @users[a[0].to_i].push(a[1].to_i)
			
		end
	end
	#adds all the ratings of a movie together to determine how popular it is
	#this means a movie with 100 1 star reviews is higher than one with 10 5 star reviews
	def popularity(movie_id)
		@movies[movie_id]
	end
	#fills @most_popular with most popular movies
	def popularity_list
		temp_hash = Hash.new(0)
		temp_hash = @movies.clone
		while temp_hash.size > 0
			@most_popular.push(temp_hash.max_by{|k, v| v}[0])
			temp_hash.delete(temp_hash.max_by{|k, v| v}[0])
		end
	end
	def similarity(user1, user2)
		similarity_number = 0
		@users[user1].each do |movie|
			if @users[user2].include?(movie)
				similarity_number = 1 + similarity_number
			end
		end
		similarity_number
	end
	#go down entire list comparing all to u
	def most_similar(u)
		temp_hash = {}
		result = []
		for i in 0..@users.size do
			temp_hash[i] = similarity(u, i)
		end
		temp_hash.delete(temp_hash.max_by{|k, v| v}[0]) #top one is always going to be itself
		while temp_hash.size > 0
			result.push(temp_hash.max_by{|k, v| v}[0])
			temp_hash.delete(temp_hash.max_by{|k, v| v}[0])
		end
		result
	end
end
data = MovieData.new
data.load_data
data.popularity_list
puts "first 10 most popular:"
puts data.most_popular.first(10)
puts "last 10 most popular"
puts data.most_popular.last(10)
puts "first 10 most similar(1): "
puts data.most_similar(1).first(10)
puts "last 10 most similar(1): "
puts data.most_similar(1).last(10)