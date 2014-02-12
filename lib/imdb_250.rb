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

Movie::MOVIES.collect {|film| "#{film.info} \n"}
