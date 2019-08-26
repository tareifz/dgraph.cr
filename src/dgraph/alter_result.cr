require "json"

class Response
  JSON.mapping(
    code: String,
    message: String
  )
end

class AlterResult
  JSON.mapping(
    data: Response?,
    errors: {
      type: Array(Response),
      default: [] of Response
    }
  )

  def success?() : Bool
    if @data
      true
    else
      false
    end
  end

  def fail?() : Bool
    !success?()
  end
end
