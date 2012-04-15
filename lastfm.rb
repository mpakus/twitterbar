# simple Last.fm class
class LastFM
  require 'open-uri'
  require 'csv'
  
  class << self
    
    CACHE_DIR = './recents/'
     
    def get_tracks user_name
      download user_name
      get_data user_name
    end
    
    protected
  
    def download user_name
      fw = open CACHE_DIR + "#{user_name}.txt", 'wb' 
      fw.write open("http://ws.audioscrobbler.com/1.0/user/#{user_name}/recenttracks.txt").read
      fw.close    
    end
    
    def get_data user_name
      file_name = CACHE_DIR + "#{user_name}.txt" 
      if File.readable? file_name
        file_data = CSV.read file_name, :col_sep => ',', :row_sep=>"\n"
      end
      file_data
    end
  end
end