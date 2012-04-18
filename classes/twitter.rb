# simple class for get last post from Twitter
class Twitter
  require 'open-uri'
  require 'csv'
  require 'json'
  
  class << self

    last_post = nil
     
    def get_last_post user_name
      download user_name
      get_data user_name
    end
    
    protected
  
    def download user_name
      @last_post = open("http://api.twitter.com/1/statuses/user_timeline/#{user_name}.json").read
    end
    
    def get_data user_name
      JSON.parse @last_post
    end

  end
end