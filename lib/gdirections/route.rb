module Gdirections
  class Route
    attr_accessor :name, :steps, :distance, :travel_time

    class << self
      # get driving directions from the origin to the specified destination(s)
      # @param origin [Gdirections::Location] the starting point for the trip
      # @param destinations [Array] a list of destinations to drive to
      # @return [Gdirections::RouteCollection] a list of potential routes for the trip
      def find(origin, destination, options={})
        q = {:sensor => 'false', :origin => origin.desc_cgi, :destination => destination.desc_cgi}.merge(options)
        url = "http://maps.googleapis.com/maps/api/directions/json?"+build_query(q)
        uri = URI.parse(url)
        resp = Net::HTTP.get(uri)
        routes = parse(resp)
      end

      # parses response from google
      # @param the response received from google
      # @return [Gdirections::RouteCollection] returns a route collection based on the request
      def parse(response)
        resp = JSON.parse(response.body)

        code = response.code 
        routes = Gdirections::RouteCollection.new
        if code == "200"
          resp["routes"].each do |r|
            route = new 
            route.distance = r["Distance"]["html"].gsub("&nbsp;mi", "").to_f
            route.travel_time = ChronicDuration.parse(r["Duration"]["html"])
            route.steps = Gdirections::RouteStep.parse(r["Steps"])

            routes << route
          end 

        else
          routes.errors = [error_for(code)]
        end
        routes
      end

      private
      # get a frientdy error message for the status code specified
      # @param code [Integer] code to translate
      # @return [String] a friendly error message
      def error_for(code)
        if code == "602"
          "Bad Address Specified"
        elsif code == "500"
          "Server Error"
        end
      end
      
      def build_query opts=nil
        query = []
        if !opts.nil? && !opts.empty?
          opts.each do |k,v|
            query << "#{k.to_s}=#{v}"
          end
        end
        query.join('&')
      end
    end
  end
end
