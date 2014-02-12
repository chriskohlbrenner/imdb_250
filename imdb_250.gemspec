Gem::Specification.new do |s|
  s.name        = 'imdb_250'
  s.version     = '0.0.0'
  s.date        = '2014-02-12'
  s.summary     = "IMDB top 250 from your Terminal"
  s.description = "Scrapes IMDB's top 250 movies and data from each movie."
  s.authors     = ["Chris Kohlbrenner", "Danny Fenjves"]
  s.email       = 'c.kohlbrenner@gmail.com'
  s.files       = ["lib/imdb_250.rb"]
  s.homepage    =
    'http://rubygems.org/gems/imdb_250'
  s.license       = 'MIT'
  s.add_runtime_dependency "nokogiri", [">=0"]

end