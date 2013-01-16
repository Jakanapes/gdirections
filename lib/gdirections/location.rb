module Gdirections
  # Represents a location that you would want directions from or to
  # A location has the following attributes:
  # * description
  class Location
    attr_accessor :description

    # create a new location
    # @param description [String] address or zipcode of the location
    def initialize(description)
      @description = description
    end
    
    def desc_cgi
      CGI::escape @description
    end

    # get routes to the destinations specified
    # @example 
    #   @origin = Gdirections::Location.new("4 Yawkey Way, Boston, MA")
    #   @destination = Gdirections::Location.new("1 Fleetcenter Place, Boston, MA")
    #   @routes = @origin.drive_to(@destination)
    #   if @routes.found?
    #     @routes[0].distance              #distance in miles
    #     @routes[0].drive_time            #drive time in seconds
    #     @routes[0].name                  #name of route (usually specified when multiple routes are returned)
    #     @routes[0].steps                 #array of Gdirections::Steps to take
    #     @routes[0].steps[0].distance     #distance of step in miles
    #     @routes[0].steps[0].description  #summary of step
    #   else
    #     puts @routes.errors.join(",")
    #   end
    # @param destination Gdirections::Location a single location to drive to
    # @return [Gdirections::RouteCollection] a collection of potential routes to specified destination(s)
    def path_to(destination, options = {})
      Gdirections::Route.find(self, destination, options)
    end
  end
end
