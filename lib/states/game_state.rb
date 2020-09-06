module Game
  class GameState < CyberarmEngine::GuiState
    def setup
      @field = Field.new
      @collisions = []

      @field.add_robot(Robot.new(speed: 12, turn_speed: 10, x: 40, y: 40))

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
        # puts "#{a} intersects #{b}" unless a.is_a?(Stone) || (a.is_a?(Impassable) && b.is_a?(Impassable))

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
          next if a.is_a?(Impassable) && b.is_a?(Impassable)

          if Polygon.intersect?(a.polygon, b.polygon)
            @collisions << [a, b]# unless @collisions.include?( [b, a] )
          end
        end
      end
    end

    # https://gamedevelopment.tutsplus.com/tutorials/how-to-create-a-custom-2d-physics-engine-the-basics-and-impulse-resolution--gamedev-6331
    def resolve_collisions
      @collisions.each do |a, b|
        relative_velocity = b.velocity - a.velocity
        normal = (b.position - a.position).normalized
        velocity_along_normal = normal.dot(relative_velocity)

        if velocity_along_normal > 0.1
          return
        else
          a.velocity *= 0 if b.is_a?(Impassable)
          b.velocity *= 0 if a.is_a?(Impassable)
        end

        e = [ a.restitution, b.restitution ].min
        j = -(1.0 + e) * velocity_along_normal
        j /= a.mass_inverse + b.mass_inverse

        impulse = normal * j

        a.velocity -= impulse * a.mass_inverse
        b.velocity += impulse * b.mass_inverse
      end
    end

    def update
      super
      collision_detection
      resolve_collisions

      string = ""

      @field.robots.each do |robot|
        position = Field.position_to_field(robot.position)
        x = position.x.round(2)
        y = position.y.round(2)
        real_x = robot.position.x.round(2)
        real_y = robot.position.y.round(2)

        string += "Robot position:\n   X: #{x}\" (#{real_x})\n   Y: #{y}\" (#{real_y})\n"
      end

      @label.value = string
    end
  end
end