# dgraph

Dgraph client using HTTP API

## Status

This library still under development, and the API may change completely, contributions and suggestions are welcomed.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     dgraph:
       github: tareifz/dgraph
   ```

2. Run `shards install`

## Usage

```crystal
require "dgraph"
```

### Query

```crystal
require "dgraph"

class Test
  class Movie
    JSON.mapping(
      name: String
    )
  end

  JSON.mapping(
    movie: Array(Movie)
  )
end

client = Dgraph::Pooled.new

res = client.query(%(
    query test($name: string) {
      movie(func: allofterms(name, $name)) {
        name
      }
    }
), {"$name" => "Star Wars"})

result = Dgraph::QueryResult(Test).from_json(res)

if result.errors.empty?
  result.data.try do |data|
    data.movie.each do |mov|
      pp mov.name
    end
  end
else
  result.errors.each do |err|
    pp err.code
  end
end
```

### Alter

```crystal
require "dgraph"

client = Dgraph::Pooled.new

res = client.alter(%(
  name: string @index(term) .
))

if res.success?
  res.data.try do |data|
    pp data.message
  end
end

if res.fail?
  res.errors.each do |err|
    pp err.message
  end
end
```

## TODO

- [x] Query
- [x] Alter
- [ ] Mutations
- [ ] Transactions

## Contributing

1. Fork it (<https://github.com/tareifz/dgraph/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [tareifz](https://github.com/tareifz) - creator and maintainer
