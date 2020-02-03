module Game
  class Stone < CyberarmEngine::GameObject
    def setup
      @image = Gosu::Image.new(GAME_ROOT_PATH + "/assets/stone.png")
      self.scale = 0.5
    end

    def game_width
      4 # inches
    end

    def game_height
      8 # inches
    end
  end
end