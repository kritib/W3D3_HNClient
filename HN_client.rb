#Kriti

require 'nokogiri'
require 'rest-client'

# page = Nokogiri::HTML(RestClient.get('http://news.ycombinator.com/news'))

# File.open("hacker_news", "w") {|f| f.puts page}


class HomePage


end

page = Nokogiri::HTML(File.read("hacker_news.html"))


links = page.css("tr > td.title > a")
subtexts = page.css("tr > td.subtext > a")

links_list = []
links.each do |link|
  links_list << [link.text, link.attr('href')]
end

subtexts_list = []
subtexts.each_with_index do |subtext, i|
  links_list[i/2] << subtext.text
  links_list[i/2] << subtext.attr('href')
end

class Post


end

class User

end

class Comment

end



# screen

