# simple ImageBar class
class ImageBar
  require 'RMagick'
   
  class << self
    
    def draw theme_dir, theme, tracks, conf
      # load template image
      img = Magick::ImageList.new theme_dir + theme + '.gif'
      
      text = Magick::Draw.new
      text.font_family = conf.font_family
      text.pointsize   = conf.font_size.to_i
      text.gravity     = Magick::NorthWestGravity
      
      # draw the list of tracks
      i = 0
      tracks.each do |track|
        text.annotate( img, 0, 0, conf.left.to_i, conf.top.to_i + (i * (conf.font_size.to_i + 4)), track[1] ){
          self.fill = conf.color
        }
        break if i == ( conf.count.nil? ? 5 : conf.count.to_i-1 )
        i+=1
      end
      
      img.to_blob    
    end
    
  end
end