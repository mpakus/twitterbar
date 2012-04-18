# simple ImageBar class
class ImageBar
  require 'RMagick'
   
  class << self
    
    def draw theme_dir, theme, twit, conf
      # load template image
      img = Magick::ImageList.new theme_dir + theme + '.gif'
      
      text = Magick::Draw.new
      # self.font_family = 'Helvetica'
      text.font_family = conf.font_family
      text.pointsize   = conf.font_size.to_i
      text.gravity     = Magick::NorthWestGravity
      text.fill        = conf.color
      #text.font_we

      # draw text on background      
      text.annotate img, 200, 80, 110, 10, wrap_text( twit[0]['text'] )      
      img.to_blob    
    end

    def wrap_text(txt, col = 30)
      txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n") 
    end
    
  end
end