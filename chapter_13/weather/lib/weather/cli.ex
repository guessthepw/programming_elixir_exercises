defmodule Weather.CLI do
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    OptionParser.parse(argv,
      switches: [help: :boolean],
      aliases: [h: :help]
    )
    |> elem(1)
  end

  def process(:help) do
    IO.puts("""
    usage:  weather <link>
    """)

    System.halt(0)
  end

  def process(link) do
    Weather.GetWeather.fetch(link)
    |> decode_responses()
    |> print_results()
  end

  def print_results(results) do
    Enum.map(results, fn {k, v} -> IO.puts("** #{format_atom_to_string(k)} : #{v} **") end)
  end

  def format_atom_to_string([head | tail]) do
    words = [head | tail]

    for word <- words do
      str = String.downcase(word)
      String.replace(str, String.first(str), String.upcase(String.first(str))) <> " "
    end
  end

  def format_atom_to_string(atom) do
    Atom.to_string(atom)
    |> String.split("_")
    |> format_atom_to_string()
  end

  def decode_responses({:ok, body}), do: List.first(body)

  def decode_responses({:error, error}) do
    IO.puts("Error fetching from weather: #{error["message"]}")
    System.halt(2)
  end
end
