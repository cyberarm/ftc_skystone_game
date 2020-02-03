module Game
  class Foundation < CyberarmEngine::GameObject
    def setup
      if @options[:side] == :blue
        @image = Gosu::Image.new(GAME_ROOT_PATH + "/assets/blue_foundation.png")
      else
        @image = Gosu::Image.new(GAME_ROOT_PATH + "/assets/red_foundation.png")
      end

      self.scale = 0.5
    end

    def game_width
      18.5 # inches
    end

    def game_height
      34.5 # inches
    end
  end
end