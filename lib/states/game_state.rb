module Game
  class GameState < CyberarmEngine::GuiState
    def setup
      @field = Field.new
      @collisions = []

      @field.add_robot(Robot.new(speed: 12, turn_speed: 10))

      @label = label "", z: Float::INFINITY
    end

    def draw
      super

      debug_collisions
    end

    def debug_collisions
      @game_objects.each do |object|
        next unless object.is_a?(Game::GameObject)
        object.color = Gosu::Color::WHITE
      end

      @collisions.each do |a, b|
        puts "#{a} intersects #{b}" unless a.is_a?(Stone) || (a.is_a?(Impassable) && b.is_a?(Impassable))

        a.color = Gosu::Color::GRAY
        b.color = Gosu::Color::GRAY
      end
    end

    def collision_detection
      game_objects_with_polygons = @game_objects.find_all { |g| g.is_a?(Game::GameObject) }

      @collisions.clear
      game_objects_with_polygons.each do |a|
        game_objects_with_polygons.each do |b|
          next if a == b
          next unless a.collidable?
          next unless b.collidable?

          if Polygon.intersect?(a.polygon, b.polygon)
            @collisions << [a, b]

            # TODO: Physics
            # a_velocity = a.velocity.clone / a.mass
            # b_velocity = b.velocity.clone / b.mass

            # a.velocity += b_velocity
            # b.velocity += a_velocity
          end
        end
      end
    end

    def update
      super
      collision_detection

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