require_relative "route_calculator"
require_relative "route"
require "test/unit"
 
class TestRouteCalculator < Test::Unit::TestCase
 
    def setup
        @calc = RouteCalculator.new("graph")
    end

    def test_start_and_end
        routes = @calc.possible_routes("A", "C")
        assert_equal(routes.length, 4)
        assert(routes.include? Route.new(["A", "B", "C"], 9))
        assert(routes.include? Route.new(["A", "D", "C"], 13))
        assert(routes.include? Route.new(["A", "D", "E", "B", "C"], 18))
        assert(routes.include? Route.new(["A", "E", "B", "C"], 14))
    end
    
    def test_many_stops
        route = @calc.find_route("A", "D", "C")
        assert_equal(route, Route.new(["A", "D", "C"], 13))
    end

    def test_no_path_exists
        assert_raises(ArgumentError) {routes = @calc.find_route('B', 'A')}
    end

    def test_avoids_looping_path
        routes = @calc.possible_routes('B', 'E')
        assert_equal(routes.length, 2)
        assert(routes.include? Route.new(["B", "C", "D", "E"], 18))
        assert(routes.include? Route.new([ "B", "C", "E"], 6))
    end

    def test_no_infinite_looping
        assert_raises(ArgumentError) {routes = @calc.find_routes("A", "E", [], true)}
    end

    def test_max_stops
        routes = @calc.routes_with_max_stops("C", "C", 3)
        assert_equal(routes.length, 2)
        assert(routes.include? Route.new(["C", "D", "C"], 16))
        assert(routes.include? Route.new(["C", "E", "B", "C"], 9))
    end

    def test_max_distance
        routes = @calc.routes_shorter_than("C", "C", 18)
        assert_equal(routes.length, 2)
        assert(routes.include? Route.new(["C", "D", "C"], 16))
        assert(routes.include? Route.new(["C", "E", "B", "C"], 9))
    end
end