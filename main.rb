require "./route_calculator.rb"

calc = RouteCalculator.new("graph")

# 1. The distance of the route A-B-C
puts "1. #{calc.find_route("A", "B", "C")}"

# 2. The distance of the route A-D
puts "2. #{calc.find_route("A", "D")}"

# 3. The distance of the route A-D-C
puts "3. #{calc.find_route("A", "D", "C")}"

puts "4. #{calc.find_route("A", "E", "B", "C", "D")}"

begin
    puts "5. #{calc.find_route("A", "E", "D")}"
rescue => e
    puts "5. #{e.message}"
end

route6 = calc.routes_with_max_stops("C", "C", 3)
puts "6. #{route6.length} possible paths"
route6.each do |path|
    puts path
end

route7 = calc.routes_with_exact_stops("A", "C", 4)
puts "7. #{route7.length} possible paths"
route7.each do |path|
    puts path
end

puts "8. #{calc.shortest_route("A", "C")}"

puts "9. #{calc.shortest_route("B", "B")}"

route10 = calc.routes_shorter_than("C", "C", 30)
puts "10. #{route10.length} possible paths"
route10.each do |path|
    puts path
end 