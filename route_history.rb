class RouteHistory < Array
    # Method: include?
    # Checks for the given stop in the history ignoring the starting point
    def include?(stop)
        length > 0 and slice(1..).include? stop
    end

    # Method: with_stops
    # Generates a new history with the given stops added
    # Return: RouteHistory
    def copy_with_stops(*stops)
        RouteHistory.new(self + stops)
    end
end