module Game
  class Field < CyberarmEngine::GameObject
    # Converts field inches to screen pixels
    def self.field_to_screen(position)
      position * 4.166666666666667
    end

    # Converts screen pixels to field inches
    def self.position_to_field(position)
      (position / 4.166666666666667)
    end

    attr_reader :robots
    def setup
      @image = Gosu::Image.new(GAME_ROOT_PATH + "/assets/skystone_field.png")
      @position.x, @position.y = window.width / 2, window.height / 2
      self.scale = 0.5

      @robots = []

      setup_field
    end

    def setup_field
      blue = Foundation.new(side: :blue)
      red = Foundation.new(side: :red)
      blue.position = Field.field_to_screen( CyberarmEngine::Vector.new( 48.25 + (18.5 / 2), 4 + (35.5 / 2) ) )
      red.position = Field.field_to_screen( CyberarmEngine::Vector.new( 48.25 + ((18.5 / 2) * 2) + 19.75, 4 + (35.5 / 2) ) )

      6.times do |i|
        stone = Stone.new
        stone.position = Field.field_to_screen(
          CyberarmEngine::Vector.new(
            (12 * 4) + stone.game_width / 2,
            ((12 * 12) - (stone.game_height / 2)) - (i * stone.game_height)
          )
        )
      end

      6.times do |i|
        stone = Stone.new
        stone.position = Field.field_to_screen(
          CyberarmEngine::Vector.new(
            (12 * 4 * 2) - stone.game_width / 2,
            ((12 * 12) - (stone.game_height / 2)) - (i * stone.game_height)
          )
        )
      end

      Bridges.new
    end

    def add_robot(robot)
      @robots << robot
    end

    def game_width
      144.0 # inches
    end

    def game_height
      144.0 # inches
    end
  end
end