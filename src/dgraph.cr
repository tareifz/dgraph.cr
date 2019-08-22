require "pool/connection"
require "http/client"
require "uri"

module Dgraph

  class Client
    @connection : HTTP::Client
    @uri : String

    def initialize(@uri = "http://localhost:8080")
      @connection = HTTP::Client.new(
        URI.parse(@url)
      )
    end
  end

  class Pooled
    @pool : ConnectionPool(Client)
    @uri : String
    @capacity : Int32
    @timeout : Float64

    def initialize(@uri = "http://localhost:8080", @capacity = 5, @timeout = 5.0)
      @pool = ConnectionPool.new(@capacity, @timeout) do
        Client.new()
      end

    end
  end

end
