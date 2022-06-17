# TrainStopSolution

## RouteCalculator
#### Method: initialize
Loads all possible tracks from the file given
#### Parameters:
**filepath**: A string pointing to the file that contains route distances

---

#### Method: routes_with_max_stops
Finds all possible routes with the number of stops given or less
#### Parameters:
**start**: Starting point of the route

**finish**: Ending stop of valid routes

**num_stops**: Maximum number of stops in a valid route
#### Returns: Array of Routes

---

#### Method: routes_with_exact_stops
Finds all possible routes between two stops with the given number of stops
#### Parameters:
**start**: Starting point of the route

**finish**: Ending stop of valid routes

**num_stops**: Number of stops in a valid route

#### Returns: Array of Routes

---

#### Method: routes_shorter_than
Finds all possible routes between two stops less than a given distance

#### Parameters:
**start**: Starting point of the route

**finish**: Ending stop of valid routes

**distance**: Maximum distance of a valid route

#### Returns: Array of Routes

---

#### Method: shortest_route
Finds the shortest route betwen two stops

#### Parameters:
**start**: Starting point of the route

**finish**: Ending stop of valid route

#### Returns: Route

---

#### Method: possible_routes
Finds all routes that do not repeat stops
#### Parameters:
**start**: Starting point of the route

**finish**: Ending stop of valid route

### Returns: Array of Routes

---

#### Method: find_route
Attempt to find a valid route that matches the stops given

#### Parameters:
**stops**: The stops in the desired Route

#### Returns: Route

#### Raises ArgumentError
When no valid route is found

---

#### Method: find_routes
Recursively find possible routes

#### Parameters:
**a**: Stop to start from

**b**: Stop to find a route to

***valid_routes**: Array for storing valid routes

**looping**: True if repeating stops is allowed

**dist**: distance of the current Route being traced

**max_dist**: Maximum distance allowed for valid Routes

**max_stops**: Maximum stops allowed for valid Routes

#### Raises: ArgumentError
When looping will cause infinite routes to be found
