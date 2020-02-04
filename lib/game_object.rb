module Game
  class GameObject < CyberarmEngine::GameObject
    attr_reader :polygon, :mass

    def initialize(options = {})
      options[:scale_x] ||= 0.5
      options[:scale_y] ||= 0.5

      @polygon = Polygon.new
      @collidable = true

      @movement_drag = 0.94
      @turn_drag = 0.94

      super(options)

      @speed = options[:speed] || 6
      @turn_speed = options[:turn_speed] || 5
      @mass = options[:mass] || 10.0
    end

    def draw
      super

      half_width = 2
      @polygon.points.each do |point|
        window.draw_rect(*(point - half_width).to_a[0..1], half_width * 2, half_width * 2, Gosu::Color::RED, Float::INFINITY)
      end
    end

    def collidable?
      @collidable
    end

    def update
      super

      @position += @velocity.xy
      @angle += @velocity.z
      @velocity.x *= @movement_drag
      @velocity.y *= @movement_drag
      @velocity.z *= @turn_drag

      @angle %= 360.0

      update_polygon
    end

    def update_polygon
      # TODO: Create bounding box
      @polygon.points.clear

      top_left = @position.clone
      top_left.x -= width / 2
      top_left.y -= height / 2

      top_right = @position.clone
      top_right.x += width / 2
      top_right.y -= height / 2

      bottom_left = @position.clone
      bottom_left.x -= width / 2
      bottom_left.y += height / 2

      bottom_right = @position.clone
      bottom_right.x += width / 2
      bottom_right.y += height / 2

      @polygon.points.push(top_left, top_right, bottom_right, bottom_left)

      radians = @angle.degrees_to_radians
      @polygon.points.each do |vector|
        temp = vector - @position

        rotated = CyberarmEngine::Vector.new(
          temp.x * Math.cos(radians) - temp.y * Math.sin(radians),
          temp.x * Math.sin(radians) + temp.y * Math.cos(radians)
        )

        pos = rotated + @position
        vector.x, vector.y = pos.x, pos.y
      end
    end
  end
end