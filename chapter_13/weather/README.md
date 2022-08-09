# Weather
Returns formatted weather data from XML.

## Usage
```elixir
cd weather
mix escript.build
./weather <LINK_TO_XML>

EX: ./weather https://w1.weather.gov/xml/current_obs/KTEB.xml
```

or

```elixir
cd weather
iex -S mix
Weather.CLI.process("https://w1.weather.gov/xml/current_obs/KTEB.xml")
```


