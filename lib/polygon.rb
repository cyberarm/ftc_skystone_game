module Game
  class Polygon
    attr_reader :points
    def initialize(points = [])
      @points = points
    end

    # Based on the seperating axis theorem
    # Derived from: https://gist.github.com/nyorain/dc5af42c6e83f7ac6d831a2cfd5fbece
    def self.intersect?(a, b)
      a.points.each_with_index do |point, i|

        # Calculate normal vector
        next_point = a.points[(i + 1) % a.points.size]
        edge = next_point - point

        axis = CyberarmEngine::Vector.new(-edge.x, edge.y)

        a_max_project = -Float::INFINITY
        a_min_project = Float::INFINITY
        b_max_project = -Float::INFINITY
        b_min_project = Float::INFINITY

        a.points.each do |vector|
          project = axis.dot(vector)
          a_min_project = project if project < a_min_project
          a_max_project = project if project > a_max_project
        end

        b.points.each do |vector|
          project = axis.dot(vector)
          b_min_project = project if project < b_min_project
          b_max_project = project if project > b_max_project
        end

        return false if a_max_project < b_min_project || a_min_project > b_max_project
      end

      return true
    end
  end
end