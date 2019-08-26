require "json"

class Dgraph::QueryResult(T)
  class Error
    JSON.mapping(
      code: String,
      message: String
    )
  end

  JSON.mapping(
    errors: { type: Array(Error), default: [] of Error },
    data: T?
  )
end
