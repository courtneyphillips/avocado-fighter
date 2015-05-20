require 'gosu'
require './lib/player.rb'
require './lib/zorder.rb'
require './lib/star.rb'
# require 'pry'

class GameWindow < Gosu::Window

  GAMETIME = 15

  def initialize
# binding.pry
    super 640, 480, false
    self.caption = "TAMAGOTHI"
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @background_image = Gosu::Image.new(self, "media/Background.png", true)
    @player = Player.new(self)
    @player.warp(320, 240)
    @time_spent = 0
    @time_spent_message = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @time_spent_value = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @items_collected_message = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @items_collected_count =Gosu::Font.new(self, Gosu::default_font_name, 20)
    @final_score_msg = Gosu::Image.from_text(self, "GAME OVER !!!", Gosu.default_font_name, 50)
    @message_height = 700
    @star_anim = Gosu::Image::load_tiles(self, "media/pizza.jpg", 25, 25, false)
    @stars = Array.new
    @counter = 0
  end

  def time_up?
    @time_spent/60 == GAMETIME
  end


  def update
    @time_spent = @time_spent + 1 if @time_spent/60 < GAMETIME
    if time_up?
      # @game_sound.stop
      @message_height =250
    else
      ##play/movement##
      @counter = @counter + 1
    # elsif
    #  star.update
    end


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
    @player.collect_stars(@stars)

    if rand(100) < 4 and @stars.size < 1

      # add @star.anim as argument to reinstate animation
      @stars.push(Star.new(@star_anim))
    end
      # if time_up?
      # @message_height = 250
    # end

  end



  def draw
    @player.draw
    @background_image.draw(0, 0, ZOrder::Background)
    @stars.each { |star| star.draw }
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)

    @time_spent_message.draw("Time Remaining:", 0 , 0, 1)
    @time_spent_value.draw(GAMETIME - @time_spent/60, 150, 0, 1)
    @items_collected_message.draw("Stars Collected:", 0 , 50, 1)
    @items_collected_count.draw(@counter, 160 , 50, 1)
    @final_score_msg.draw(200, @message_height, 1)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end



end


window = GameWindow.new
window.show
