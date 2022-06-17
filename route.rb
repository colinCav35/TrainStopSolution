class Route
    attr_reader :path, :distance

    def initialize(path, distance)
        @path = path
        @distance = distance
    end

    def ==(other)
        self.path == other.path &&
        self.distance == other.distance
    end

    def to_s
        return "Path: #{@path}, Distance: #{@distance}"
    end
end