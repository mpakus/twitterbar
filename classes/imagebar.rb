# simple ImageBar class
class ImageBar
  require 'RMagick'
   
  class << self
    
    def draw theme_dir, theme, twit, conf
      # load template image
      img = Magick::ImageList.new theme_dir + theme + '.gif'
      
      text = Magick::Draw.new
      text.font        = conf.font
      text.pointsize   = conf.font_size.to_i
      text.gravity     = Magick::NorthWestGravity
      text.fill        = conf.color
      text.kerning     = conf.kerning
      text.interline_spacing = conf.interline_spacing

      # draw text on background      
      text.annotate img, conf.width, conf.height, conf.left, conf.top, wrap_text( twit[0]['text'], conf.chars_in_row )      
      img.to_blob    
    end

    def wrap_text(txt, col = 30)
      txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n") 
    end
    
  end
end