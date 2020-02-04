module Game
  class Field < Game::GameObject
    MAGIC = 4.166666666666667

    # Converts field inches to screen pixels
    def self.field_to_screen(position)
      position * MAGIC
    end

    # Converts screen pixels to field inches
    def self.position_to_field(position)
      (position / MAGIC)
    end

    attr_reader :robots
    def setup
      @image = Gosu::Image.new(GAME_ROOT_PATH + "/assets/skystone_field.png")
      @collidable = false
      @position.x, @position.y = window.width / 2, window.height / 2

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

      strut_thickness = 2 * MAGIC
      wall_thickness = 6 * MAGIC
      wall_length = 144 * MAGIC
      # Bridge left support
      left_support = Field.field_to_screen(
        CyberarmEngine::Vector.new(
          (12 * 6) - 23,
          (12 * 6),
        )
      )
      Impassable.new(
        x: left_support.x, y: left_support.y,
        width: strut_thickness, height: 18.5 * MAGIC
      )

      # Bridge right support
      left_support = Field.field_to_screen(
        CyberarmEngine::Vector.new(
          (12 * 6) + 23,
          (12 * 6),
        )
      )
      Impassable.new(
        x: left_support.x, y: left_support.y,
        width: strut_thickness, height: 18.5 * MAGIC
      )

      # Left wall
      Impassable.new(
        x: -(wall_thickness / 2), y: wall_length / 2,
        width: wall_thickness, height: wall_length + wall_thickness
      )
      # Right wall
      Impassable.new(
        x: wall_length + (wall_thickness / 2), y: wall_length / 2 - (wall_thickness / 2),
        width: wall_thickness, height: wall_length + wall_thickness
      )

      # Top wall
      Impassable.new(
        x: wall_length / 2 - (wall_thickness / 2), y: -(wall_thickness / 2),
        width: wall_length + wall_thickness, height: wall_thickness
      )

      # Bottom wall
      Impassable.new(
        x: wall_length / 2 - (wall_thickness / 2), y: wall_length + (wall_thickness / 2),
        width: wall_length + wall_thickness, height: wall_thickness
      )
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