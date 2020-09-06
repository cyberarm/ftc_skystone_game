module Game
  class Impassable < Game::GameObject
    def setup
      @options[:mass] = Float::INFINITY
      @width = @options[:width]
      @height = @options[:height]

      @restitution = 0.1
    end

    def draw
      color = Gosu::Color.rgba(100, 100, 100, 200)
      Gosu.draw_quad(
        @polygon.points[0].x, @polygon.points[0].y, color,
        @polygon.points[1].x, @polygon.points[1].y, color,
        @polygon.points[2].x, @polygon.points[2].y, color,
        @polygon.points[3].x, @polygon.points[3].y, color,
        Float::INFINITY
      )

      super
    end

    def width
      @width
    end

    def game_width; width; end

    def height
      @height
    end

    def game_height; height; end
  end
end