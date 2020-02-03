module Game
  class GameState < CyberarmEngine::GuiState
    def setup
      @field = Field.new

      @field.add_robot(Robot.new(speed: 12))

      @label = label "", z: Float::INFINITY
    end

    def update
      super
      string = ""

      @field.robots.each do |robot|
        position = Field.position_to_field(robot.position)
        x = position.x.round(2)
        y = position.y.round(2)

        string += "Robot position:\n   X: #{x}\"\n   Y: #{y}\"\n"
      end

      @label.value = string
    end
  end
end