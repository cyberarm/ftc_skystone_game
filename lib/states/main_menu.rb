module Game
  class MainMenu < CyberarmEngine::GuiState
    def setup
      window.show_cursor = true
      background 0xff008800

      label "FTC SkyStone Game", text_size: 64

      button "Play!", width: 1.0 do
        push_state(GameState)
      end

      button "Exit", width: 1.0, margin_top: 10 do
        window.close
      end
    end
  end
end