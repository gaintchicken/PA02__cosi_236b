require './User'
require './movie'
require './Rating'
require './MovieTest'
class MovieData
  attr_accessor :movies, :users, :path_to_training, :path_to_test, :list_of_test_set
  def initialize(location_training, location_test = nil )
    @movies = Hash.new
    @users = Hash.new
    @path_to_training = location_training
    @list_of_test_set = []
    @path_to_test = nil
    @path_to_test = location_test unless location_test.nil?
  end
  #loads data from path given in constructor
  def load_data
		File.open("#{@path_to_training}", "r").each_line do |line|
			a = line.split
			add_movie(a[1].to_i, a[0].to_i, a[2].to_i)
			add_user(a[0].to_i, a[1].to_i, a[2].to_i)
		end
		if File.file?("#{@path_to_test}") then
			File.open("#{@path_to_test}", "r").each_line do |line|
				a = line.split
				@list_of_test_set << Rating.new(a[0].to_i, a[1].to_i, a[2].to_i)
			end
		end
	end

	def add_movie(movie_id, user_id, rating)
		#if @movies already has a movie there, use add method, else make new one
		if (!@movies[movie_id].nil?) then #movie already exists
			@movies[movie_id].add_rating(user_id, rating)
		else

			@movies[movie_id] = Movie.new(user_id, rating)
		end
	end

	def add_user(user_id, movie_id, rating)
		#if @users already has a movie there, use add method, else make new one
		if (!@users[user_id].nil?) then
			@users[user_id].add_rating(movie_id, rating)
		else
			@users[user_id] = User.new(movie_id, rating)
		end
	end

	def rating(user_id, movie_id)
		@users[user_id].get_rating(movie_id)
	end

	def predict(user_id, movie_id)
		arr = @users[user_id].movies_watched.values
		arr.inject(0.0) {|sum, e1| sum + e1} / arr.size
	end

	def movies(user_id)
		@users[user_id].movie_list
	end

	def viewers(movie_id)
		@movies[movie_id].users_rated
	end

	def run_test(k = nil)
		length = list_of_test_set.size
		length = k unless k.nil?
		mt = MovieTest.new(list_of_test_set[0], predict(list_of_test_set[0].user_id, list_of_test_set[0].movie_id))
		for i in 1..length do
			mt.add(list_of_test_set[i], predict(list_of_test_set[i].user_id, list_of_test_set[i].movie_id))
		end
		mt
	end

end

md = MovieData.new("data/u1.base", "data/u1.test")
md.load_data
puts Time.now
mt = md.run_test(10000)
puts Time.now
puts mt.mean
puts mt.stddev
puts mt.rms
mt.to_a