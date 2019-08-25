module Dgraph::Operation
  # abstract def alter()
  abstract def query(q : String, vars = {} of String => String) : String
  # abstract def mutate()
  # abstract def commit()
end
