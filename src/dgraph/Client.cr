require "http/client"
require "uri"

require "./Operation"

class Dgraph::Client
  include Operation

  @connection : HTTP::Client

  def initialize(uri : String = "http://localhost:8080")
    @connection = HTTP::Client.new(
      URI.parse(uri)
    )
  end

  def query(q : String, vars = {} of String => String) : String
    headers = HTTP::Headers {"Content-Type" => "application/json"}

    headers["X-Dgraph-Vars"] = vars.to_json unless vars.empty?

    res = @connection.post(
      "/query",
      headers: headers,
      body: q
    )

    res.body

  end

end
