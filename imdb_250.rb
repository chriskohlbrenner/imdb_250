require 'nokogiri'
require 'open-uri'
require 'pry'

html_250 = open("http://www.imdb.com/chart/top")
top_250 = Nokogiri::HTML(html_250)

top_250_array = top_250.css("table.chart tbody td.posterColumn a").collect{ |x| x["href"]}


class Movie
  MOVIES = []
  def initialize(link)
    @html = open(link)
    @film = Nokogiri::HTML(@html)
    puts "scraping #{link}"
    @film_data = { 
      :title => @film.css("h1.header span.itemprop").text,
      :directors => @film.css("div[itemprop=director] span").collect {|director| director.text},
      :actors => @film.css("div[itemprop=actors] span[itemprop=name]").collect {|actor| actor.text},
      :rating => @film.css("span[itemprop=ratingValue]").text.to_f,
      # :synopsis => @film.css("p[itemprop=description]").text.strip,
      # :gross => @film.css("div.txt-block").text[/(?<=\bGross:\s)(.*)/].strip,
    }
    MOVIES << self
  end

  def film_data
    @film_data
  end

  def info
    @film_data.each{ |data_title,data| puts "#{data_title}: #{data}"}
  end

  def title
    film_data[:title]
  end


end

top_250_array[0..3].each_with_index do |link, i| 
  Movie.new("http://www.imdb.com#{link}")
  sleep 1 if i % 10 == 0
end
#"#{i+1}"


def get_movie_info
  puts "type a movie:"
  movie = gets.chomp
  Movie::MOVIES.each do |film|
   puts "#{film.info if film.title == movie}"
   puts ""
  end
end

def list_movies
  Movie::MOVIES.each_with_index do |film, i|
   puts "#{i+1}: #{film.title}"
   puts ""
  end
end

def help
  puts "Welcome to Help!"
  puts "Available Commands"
  puts "help => Takes you to this help page"
  puts "list => Lists the songs in the juke box"
  puts "movie => Get information on a specific movie"
  puts "exit => Leave the program"
end

def exit
  puts "Goodbye"
end

def run_movie_program(command)
  case command
    when "help"
      help
    when "list"
      list_movies
    when "movie"
      get_movie_info
    when "exit"
      exit
    else
      help
  end
end

def command
  puts "Please enter a command:"
  command = gets.downcase.strip
  command
end

def run
  puts "Welcome! What do you want to do?"
  loop do
    choice = command
    run_movie_program(choice)
    break if choice == "exit"
  end
end

run


