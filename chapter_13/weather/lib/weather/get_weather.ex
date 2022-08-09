defmodule Weather.GetWeather do
  require Logger
  require Record
  require IEx
  import SweetXml


  @user_agent [{"User-agent", "Elixir john.herbener@semsee.com"}]

  def fetch(link) do
    Logger.info("Fetching weather")

    link
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    Logger.info("Got response: status code=#{status_code}")
    Logger.debug(fn -> inspect(body) end)

    {
      status_code |> check_for_error(),
      body |> parse_data()
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error

  # Weather.GetWeather.fetch("https://w1.weather.gov/xml/current_obs/KTEB.xml")
  def parse_data(body) do
    body
    |> parse(dtd: :none)
    |> xpath(~x"/current_observation"l,
      [
      location: ~x"./location/text()",
      station_id: ~x"./station_id/text()",
      observation_time: ~x"./observation_time/text()",
      weather: ~x"./weather/text()",
      temperature_string: ~x"./temperature_string/text()",
      relative_humidity: ~x"./relative_humidity/text()",
      wind_string: ~x"./wind_string/text()",
      pressure_string: ~x"./pressure_string/text()",
      visibility_mi: ~x"./visibility_mi/text()",
      two_day_history_url: ~x"./two_day_history_url/text()",
      credit: ~x"./credit/text()"
      # image: [
      #   ~x"/"k,
      #   url: ~x"/current_observation/image/url/text()",
      #   title: ~x"/current_observation/image/title/text()",
      #   link: ~x"/current_observation/image/link/text()"
      # ],
      # suggested_pickup: ~x"./suggested_pickup/text()",
      # suggested_pickup_period: ~x"./suggested_pickup_period/text()",
      # latitude: ~x"./latitude/text()",
      # longitude: ~x"./longitude/text()",
      # observation_time_rfc822: ~x"./observation_time_rfc822/text()",
      # temp_f: ~x"./temp_f/text()",
      # temp_c: ~x"./temp_c/text()",
      # wind_dir: ~x"./wind_dir/text()",
      # wind_degrees: ~x"./wind_degrees/text()",
      # wind_mph: ~x"./wind_mph/text()",
      # wind_kt: ~x"./wind_kt/text()",
      # pressure_mb: ~x"./pressure_mb/text()",
      # pressure_in: ~x"./pressure_in/text()",
      # dewpoint_string: ~x"./dewpoint_string/text()",
      # dewpoint_f: ~x"./dewpoint_f/text()",
      # dewpoint_c: ~x"./dewpoint_c/text()",
      # heat_index_string: ~x"./heat_index_string/text()",
      # heat_index_f: ~x"./heat_index_f/text()",
      # heat_index_c: ~x"./heat_index_c/text()",
      # icon_url_base: ~x"./icon_url_base/text()",
      # icon_url_name: ~x"./icon_url_name/text()",
      # ob_url: ~x"./ob_url/text()",
      # disclaimer_url: ~x"./disclaimer_url/text()",
      # copyright_url: ~x"./copyright_url/text()",
      # privacy_policy_url: ~x"./privacy_policy_url/text()",
      # credit_URL: ~x"./credit_URL/text()",
      ]
    )
  end

end
