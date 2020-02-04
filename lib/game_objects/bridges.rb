module Game
  class Bridges < Game::GameObject
    def setup
      @image = Gosu::Image.new(GAME_ROOT_PATH + "/assets/bridges.png")
      @collidable = false

      self.position.x += width / 2
      self.position.y = window.height / 2
      self.position.z += 1000
    end
  end
end