module Game
  class Robot < Game::GameObject
    def setup
      @image = Gosu::Image.new(GAME_ROOT_PATH + "/assets/robot.png")

      @position += (@image.width / 2) / 2
      @angle = 90.0
    end

    def update
      super

      forward if Gosu.button_down?(Gosu::KB_UP) || Gosu.button_down?(Gosu::KB_W)
      backward if Gosu.button_down?(Gosu::KB_DOWN) || Gosu.button_down?(Gosu::KB_S)
      turn_left if Gosu.button_down?(Gosu::KB_LEFT)
      turn_right if Gosu.button_down?(Gosu::KB_RIGHT)

      strife_left if Gosu.button_down?(Gosu::KB_A)
      strife_right if Gosu.button_down?(Gosu::KB_D)
    end

    def forward
      @velocity.y -= Math.cos(@angle * Math::PI / 180) * relative_speed
      @velocity.x += Math.sin(@angle * Math::PI / 180) * relative_speed
    end

    def backward
      @velocity.y += Math.cos(@angle * Math::PI / 180) * relative_speed
      @velocity.x -= Math.sin(@angle * Math::PI / 180) * relative_speed
    end

    def strife_left
      @velocity.y -= Math.sin(@angle * Math::PI / 180) * relative_speed
      @velocity.x -= Math.cos(@angle * Math::PI / 180) * relative_speed
    end

    def strife_right
      @velocity.y += Math.sin(@angle * Math::PI / 180) * relative_speed
      @velocity.x += Math.cos(@angle * Math::PI / 180) * relative_speed
    end

    def turn_left
      @velocity.z -= @turn_speed * window.dt
    end

    def turn_right
      @velocity.z += @turn_speed * window.dt
    end

    def relative_speed
      @speed * window.dt
    end

    def game_width
      18.0 # inches
    end

    def game_height
      18.0 # inches
    end
  end
end