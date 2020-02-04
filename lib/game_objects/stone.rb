module Game
  class Stone < Game::GameObject
    def setup
      @image = Gosu::Image.new(GAME_ROOT_PATH + "/assets/stone.png")
    end

    def game_width
      4 # inches
    end

    def game_height
      8 # inches
    end
  end
end