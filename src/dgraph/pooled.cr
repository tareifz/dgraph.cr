require "pool/connection"

require "./Operation"
require "./AlterResult"

class Dgraph::Pooled
  include Operation

  @pool : ConnectionPool(Client)

  def initialize(
       uri : String = "http://localhost:8080",
       capacity : Int = 5,
       timeout : Number = 5.0
     )
    @pool = ConnectionPool.new(capacity, timeout) do
      Client.new(uri)
    end
  end

  def query(q : String, vars = {} of String => String) : String
    conn = @pool.checkout
    res = conn.query(q, vars)
    @pool.checkin(conn)

    res
  end

  def alter(q : String) : AlterResult
    conn = @pool.checkout
    res = conn.alter(q)
    @pool.checkin(conn)

    res
  end

end
