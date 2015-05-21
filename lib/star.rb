class Star

  TILE_WIDTH = 25
  TILE_HEIGHT = 25

  attr_reader :x, :y

  attr_accessor :height, :width, :x, :y, :size

  def self.load_animation(window)
     @animation ||= Gosu::Image::load_tiles(window, "media/all_food.png",
        TILE_WIDTH, TILE_HEIGHT, false)
  end

  # def self.load_sound(window)
  #   @sound ||= Gosu::Sample.new(window, "media/Beep.wav")
  # end

  def initialize(window, speed = 0.5)
    @window = window
    @staranim = self.class.load_animation(window)
    @x = rand(window.width - TILE_WIDTH)
    @y = 0
    @size = rand(3) + 1
    @height = TILE_HEIGHT * @size
    @width = TILE_WIDTH * @size
    # @beep = self.class.load_sound(window)
    @color = GameUtilities::random_color
    @speed = speed
  end

  # def destroy
  #   @window.play_sound(@beep, 0.5, (1.0 / @size.to_f))
  #   @window.remove_star(self)
  # end

  def draw
    img = @staranim[(Gosu::milliseconds / 100) % @staranim.size]
    img.draw_rot(@x, @y, ZOrder::Star, -90, 0.5, 0.5, @size, @size, @color)
  end

  def update
    @y += @speed
    if (@y - height) > @window.height
      @window.remove_star(self)
    end
  end

  def radius
    (19.0 * @size) / 2.0
  end

end








# class Star
#
#   TILE_WIDTH = 25
#   TILE_HEIGHT = 25
#
#   attr_accessor :height, :width, :x, :y, :size
#
#   def self.load_animation(window)
#      @animation ||= Gosu::Image::load_tiles(window, "media/all_food.png",
#      TILE_WIDTH, TILE_HEIGHT, tileable = false)
#   end
#
#   # def self.load_sound(window)
#   #   @sound ||= Gosu::Sample.new(window, "media/Beep.wav")
#   # end
#
#   def initialize(window, speed = 0.5)
#     @window = window
#     @staranim = self.class.load_animation(window)
#     @x = rand(window.width - TILE_WIDTH)
#     @y = 0
#     @size = rand(3) + 1
#     @height = TILE_HEIGHT * @size
#     @width = TILE_WIDTH * @size
#     @beep = self.class.load_sound(window)
#     @color = GameUtilities::random_color
#     @speed = speed
#   end
#
#   # def destroy
#   #   @window.play_sound(@beep, 0.5, (1.0 / @size.to_f))
#   #   @window.remove_star(self)
#   # end
#
#   def draw
#     img = @staranim[(Gosu::milliseconds / 100) % @staranim.size]
#     img.draw_rot(@x, @y, ZOrder::Star, -90, 0.5, 0.5, @size, @size, @color)
#   end

  # def update
  #   @y += @speed
  #   if (@y - height) > @window.height
  #     @window.remove_star(self)
  #   end
  # end

  # def radius
  #   (19.0 * @size) / 2.0
  # end

# end



class Star
  attr_reader :x, :y

  def initialize(animation)
    @animation = animation
    @color = Gosu::Color.new(0xff000000)
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
    @x = rand * 640
    @y = rand * 480
  end

  def draw
     img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
        ZOrder::Stars, 1, 1, @color, :add)
  end
end
#
#
#
#
#
#
#
#
#
# #
# class Star
#   attr_reader :x, :y
#
#   def initialize(animation)
#     @animation = animation
#     @avocado = Gosu::Image.new(window, "all_foods.png", false)
#     @x = rand * 640
#     @y = rand * 480
#   end
#
#   def draw
#     #  avocado = Gosu::milliseconds / 100 %
#     @avocado.draw(@x, @y, 1)
#     ZOrder::Stars, 1, 1, :add)
#   end
# end
