module Game
  class Robot < CyberarmEngine::GameObject
    def setup
      @speed = @options[:speed]
      @image = Gosu::Image.new(GAME_ROOT_PATH + "/assets/robot.png")
      @position += (@image.width / 2) / 2

      self.scale = 0.5
    end

    def update
      @position += @velocity
      @velocity *= 0.9

      @velocity.y -= @speed * window.dt if Gosu.button_down?(Gosu::KB_UP)
      @velocity.y += @speed * window.dt if Gosu.button_down?(Gosu::KB_DOWN)
      @velocity.x -= @speed * window.dt if Gosu.button_down?(Gosu::KB_LEFT)
      @velocity.x += @speed * window.dt if Gosu.button_down?(Gosu::KB_RIGHT)
    end

    def game_width
      18.0 # inches
    end

    def game_height
      18.0 # inches
    end
  end
end