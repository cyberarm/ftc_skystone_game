module Game
  class Polygon
    attr_reader :points
    def initialize(points = [])
      @points = points
    end

    ### !!!BROKEN!!! ###
    # Based on the seperating axis theorem
    # Derived from: https://gist.github.com/nyorain/dc5af42c6e83f7ac6d831a2cfd5fbece
    def self.sat_intersect?(a, b)
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

    def self.intersect?(a, b)
      a.points.each do |point|
        return true if point_inside?(b, point)
      end

      b.points.each do |point|
        return true if point_inside?(a, point)
      end

      return false
    end

    # https://github.com/spajus/tank_island/blob/defc528fe4d2fe9e40fa86de45b5db7782b5af80/lib/misc/utils.rb#L68
    # https://wrf.ecse.rpi.edu/Research/Short_Notes/pnpoly.html
    def self.point_inside?(polygon, test)
      points = polygon.points
      inside = false
      j = points.size - 1

      (0..points.size - 1).each do |i|
        if (((points[i].y > test.y) != (points[j].y > test.y)) &&
           (test.x < (points[j].x - points[i].x) * (test.y - points[i].y) / (points[j].y - points[i].y) + points[i].x))
          inside = !inside
        end
        j = i
      end

      inside
    end
  end
end