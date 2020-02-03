module Game
  class Bridges < CyberarmEngine::GameObject
    def setup
      @image = Gosu::Image.new(GAME_ROOT_PATH + "/assets/bridges.png")
      self.scale = 0.5
      self.position.x += width / 2
      self.position.y = window.height / 2
      self.position.z += 1000
    end
  end
end