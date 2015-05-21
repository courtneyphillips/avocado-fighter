require 'gosu'

class GameWindow < Gosu::Window

  GAMETIME = 15

  def initialize
    super 640, 480, false
    self.caption = "AVOCADO FIGHTER"
    @font = Gosu::Font.new(self, 'Arial', 30)
    @background = Background.new(self)
    @player = Player.new(self)
    @avocado = Avocado.new(self)
    @player.warp(320, 240)
    @time_spent = 0
    @time_spent_message = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @win_message = Gosu::Image.from_text(self, "YOU WIN", 'Arial', 50)
    @lose_message = Gosu::Image.from_text(self, "YOU LOSE", Gosu.default_font_name, 50)
    @final_score_msg = Gosu::Image.from_text(self, "GAME OVER", Gosu.default_font_name, 50)
    @time_spent_value = Gosu::Font.new(self, Gosu::default_font_name, 20)
    # @items_collected_message = Gosu::Font.new(self, Gosu::default_font_name, 20)
    # @items_collected_count =Gosu::Font.new(self, Gosu::default_font_name, 20)
    @message_height = 1000
    @avocados = Array.new
    @counter = 0
  end

  def time_up?
    @time_spent/60 == GAMETIME
  end

  def draw
    @background.draw
    @player.draw
    @avocados.each { |avocado| avocado.draw }
    @font.draw("Score: #{@player.score}", 0, 50, 0, 1.0, 1.0, 0xffffff00)
    @time_spent_message.draw("Time Remaining:", 0 , 0, 1)
    @time_spent_value.draw(GAMETIME - @time_spent/60, 150, 0, 1)
    # @items_collected_message.draw("avocados Collected:", 0 , 50, 1)
    # @items_collected_count.draw(@counter, 160 , 50, 1)
    # @final_score_msg.draw(200, @message_height, 1)
    if @player.score > 1
    @win_message.draw(200, @message_height, 1)
    else
    @lose_message.draw(200, @message_height, 1)
    end
  end

  def update
    @time_spent = @time_spent + 1 if @time_spent/60 < GAMETIME

    if time_up?
        @message_height =250

      else
        @counter = @counter + 1

      if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft
        @player.turn_left
      end
      if button_down? Gosu::KbRight or button_down? Gosu::GpRight
        @player.turn_right
      end
      if button_down? Gosu::KbUp or button_down? Gosu::GpButton0
        @player.accelerate
      end
      @player.move
      @player.collect_avocados(@avocados)

      if rand(100) < 4 and @avocados.size < 1
        @avocados.push(Avocado.new(self))
      end
    end
  end

    def button_down(id)
      if id == Gosu::KbEscape
        close
      end
    end
  end

#########################################

  class Player
    def initialize(window)
      @ship = Gosu::Image.new(window, "media/Teset.png", false)
      # SOUND HERE LATER
      # @beep = Gosu::Sample.new(window, "media/Beep.wav")
      @x = @y = @vel_x = @vel_y = @angle = 0.0
      @score = 0
      @width = @ship.width
      @height = @ship.height
    end

    def warp(x, y)
      @x, @y = x, y
    end

    def turn_left
      @angle -= 4.5
    end

    def turn_right
      @angle += 4.5
    end

    def accelerate
      @vel_x += Gosu::offset_x(@angle, 0.5)
      @vel_y += Gosu::offset_y(@angle, 0.5)
    end

    def move
      @x += @vel_x
      @y += @vel_y
      @x %= 640
      @y %= 480

      @vel_x *= 0.95
      @vel_y *= 0.95
    end

    def draw
      @ship.draw_rot(@x, @y, 1, @angle)
    end

    def score
      @score
    end

    def collect_avocados(avocados)
      if avocados.reject! {|avocado| Gosu::distance(@x, @y, avocado.x, avocado.y) < 35 } then
        @score += 1
        true
      else
        false
      end
    end
  end

  #########################################


  class Avocado
    attr_accessor :x, :y, :width, :height

    def initialize(window)
      @avocado = Gosu::Image.new(window, 'media/all_food.png', true)
      @x = rand * 640
      @y = rand * 480
      @width = @avocado.width
      @height = @avocado.height
      # reset(window)
    end

    def draw
      @avocado.draw(@x, @y, 1)
    end

  def reset(window)
    @y = Random.rand(window.height - @height)
    @x = window.width
  end
end

#########################################

  class Background
    attr_accessor :x, :width
    def initialize(window)
      @background_image = Gosu::Image.new(window, 'media/Background.png', true)
      @game_over_background = Gosu::Image.new(window, 'media/Background.jpg', true)
    end

    def draw
      @background_image.draw(0,0,-1)
    end
end


#########################################


window = GameWindow.new
window.show
