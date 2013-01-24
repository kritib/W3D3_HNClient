#Kriti

require 'nokogiri'
require 'rest-client'

# page = Nokogiri::HTML(RestClient.get('http://news.ycombinator.com/news'))

# File.open("hacker_news", "w") {|f| f.puts page}


class HomePage
  attr_reader :posts_list

  def initialize(num)
    @posts_list = run(num)
  end

  def run(num)

    page = Nokogiri::HTML(File.read("hacker_news.html"))


    links = page.css("tr > td.title > a")
    subtexts = page.css("tr > td.subtext > a")


    # posts_list = []
    # links.each do |link|
    #   posts_list << [link.text, link.attr('href')]
    # end

    # subtexts_list = []
    # subtexts.each_with_index do |subtext, i|
    #   posts_list[i/2] << subtext.text
    #   posts_list[i/2] << subtext.attr('href')
    # end

    # posts_list.map! do |post|
    #   Post.new(post) if post.length == 6
    # end

    posts_list = []

    num.times do |i|
      posts_list << [links[i].text, links[i].attr('href')]
    end

    (num*2).times do |i|
      posts_list[i/2] << subtexts[i].text
      posts_list[i/2] << subtexts[i].attr('href')
    end

    p posts_list[0]

    posts_list.map {|post| Post.new(post)}

  end



end

class Post
  attr_reader :title, :url, :user

  def initialize(post_info)
    @title = post_info[0]
    @url = post_info[1]
    @user = User.new(post_info[3])
    @num_comments = post_info[4].to_i
    @comments_id = post_info[5]
  end

  def get_comments
    comments = []
    comments_page = Nokogiri::HTML(RestClient.get("http://news.ycombinator.com/#{@comments_id}"))
    comheads_info = comments_page.css("tr > td.default > div > span > a")
    comments_info = comments_page.css("tr > td.default > span")


    comments_info.each do |comment|
      comments << [comment.text]
    end

    comheads_info.each_with_index do |comhead, i|
      comments[i/2] << comhead.attr('href')
    end

    comments.length
  end



end

class User
  def initialize(id)
    @screen_name = id.split('=')[1]
    @id = id
    @karma = nil
  end

  def get_karma
    if @karma.nil?
      user_page = Nokogiri::HTML(RestClient.get("http://news.ycombinator.com/#{@id}"))
      user_info = user_page.css("form > table tr > td")
      @karma = [user_info[5].text.to_i, user_info[7].text.to_f]
    end
  end

end

class Comment

end










# screen

