require_relative "route"
require_relative "route_history"

class RouteCalculator

    # Method: initialize
    # Loads all possible tracks from the file given
    def initialize(filepath)
        @tracks = {}
        File.foreach(filepath) do |line|
            line.split(',').each do |path|
                path = path.strip

                start = path[0]
                dest = path[1]
                distance = path.slice(2..).to_i

                if start.nil? or dest.nil? or distance == 0
                    raise IOError.new("Invalid route path '#{path}'")
                end

                if !@tracks.key? path[0]
                    @tracks[start] = {}
                end
                    
                @tracks[start][dest] = distance 
            end
        end
    end

    # Method: routes_with_max_stops
    # Finds all possible routes with the number of stops given or less
    # Returns: Array of Routes
    def routes_with_max_stops(start, finish, num_stops)
        total_routes = []
        find_routes(start, finish, total_routes, true, max_stops: num_stops)
        return total_routes.filter{ |path| path.path.length <= num_stops + 1 }
    end

    # Method: routes_shorter_than
    # Finds all possible routes with the given number of stops
    # Returns: Array of Routes
    def routes_with_exact_stops(start, finish, num_stops)
        total_routes = []
        find_routes(start, finish, total_routes, true, max_stops: num_stops)
        return total_routes.filter{ |path| path.path.length == num_stops + 1 }
    end

    # Method: shortest_route
    # Finds the shortest route between 2 stops
    # Returns: Route
    def shortest_route(start, finish)
        possible_routes(start, finish).min_by{ |path| path.distance }
    end

    # Method: routes_shorter_than
    # Finds all possible routes shorter than a given distance
    # Returns: Array of Routes
    def routes_shorter_than(start, finish, distance)
        total_routes = []
        find_routes(start, finish, total_routes, true, max_dist: distance)
        return total_routes
    end

    # Method: possible_routes
    # Finds all possible routes with non repeating stops
    # Returns: Array of Routes
    def possible_routes(start, finish)
        total_routes = []
        find_routes(start, finish, total_routes, false)
        return total_routes
    end

    # Method: find_route
    # Finds a path with the exact stops given
    # Returns: Route
    # Raises: ArgumentError
    def find_route(*stops)
        distance = 0
        stops.first(stops.size - 1).each_with_index do |stop, ind|
            next_stop = stops[ind+1]
            
            if @tracks[stop].include? next_stop
                distance += @tracks[stop][next_stop]
            else 
                raise ArgumentError.new("No such path exists")
            end
        end
        return Route.new(stops, distance)
    end

    # Method: find_routes
    # Recursively finds all possible routes between stops within the bounds given
    def find_routes(
        a,
        b,
        valid_routes,
        looping,
        hist: RouteHistory.new,
        dist: 0,
        max_dist: Float::INFINITY,
        max_stops: Float::INFINITY
    )
        raise ArgumentError.new("Infinite paths possible") if looping and max_dist == Float::INFINITY and max_stops == Float::INFINITY
        
        # Return if the next stop will go over the maximum number of stops
        return if hist.length == max_stops

        @tracks[a].each do |key, value|
            # Avoid repeating stops if looping is not allowed
            next if hist.include? key and !looping

            # Move to the next stop if this one will go over the maximum distance
            next if dist + value >= max_dist

            # Save valid path
            if key == b
                valid_routes.push(Route.new(hist.copy_with_stops(a, b), dist + value))
                next if !looping
            end

            # Find path from this stop to final stop
            find_routes(key, b, valid_routes, looping, hist: hist.copy_with_stops(a), dist: dist + value, max_dist: max_dist, max_stops: max_stops)
        end
    end
end