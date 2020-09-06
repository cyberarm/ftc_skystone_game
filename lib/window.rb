module Game
  class Window < CyberarmEngine::Window
    def initialize
      super(width: 600, height: 600, fullscreen: false, resizable: false)
      self.caption = "SkyStone"

      push_state(MainMenu)
    end
  end
end