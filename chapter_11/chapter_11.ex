defmodule Chapter11 do
  # StringAndBinaries-1 - Page 123
  # Write a function that returns true if a single-quoted string contains only
  # printable ASCII characters (space through tilde).
  # Note: A printable charlist in Elixir contains only the printable characters
  # in the standard seven-bit ASCII character encoding, which are characters
  # ranging from 32 to 126 in decimal notation
  # def ascii_printable?(list), do: List.ascii_printable?(list)
  # plus the following control characters:
  # ?\a - Bell
  # ?\b - Backspace
  # ?\t - Horizontal tab
  # ?\n - Line feed
  # ?\v - Vertical tab
  # ?\f - Form feed
  # ?\r - Carriage return
  # ?\e - Escape

  def ascii_printable?([head | tail])
      when head in 32..126 or
             head in 7..13 or head == 27,
      do: ascii_printable?(tail)

  def ascii_printable?([]), do: true
  def ascii_printable?(_list), do: false

  # Test commands:
  # Chapter11.ascii_printable?('cat')
  # Chapter11.ascii_printable?('abc' ++ [0])
  # StringAndBinaries-2 - Page 123
  # Write an anagram?(word1, word2) that returns true if its parameters
  # are anagrams.
  def amagram?(word1, word2) do
    word1 = Enum.sort(word1)
    word2 = Enum.sort(word2)

    if(word1 == word2) do
      true
    else
      false
    end
  end

  # Test commands:
  # Chapter11.amagram?('cat','tac')
  # Chapter11.amagram?('cat','tab')

  # StringAndBinaries-3 - Page 123
  # Try the following in IEx:
  # iex> [ 'cat' | 'dog' ] ['cat',100,111,103]
  # Why does IEx print 'cat' as a string, but 'dog' as individual numbers?

  # Because the tail of the list is always represented as a list of elements,
  # even if it's empty

  # Test commands:
  # [ 'cat' | 'dog' ]
  # [ 'dog' | 'cat' ]
  # [ ['dog',2] | 'cat' ]
  # [head | tail ] = [ ['dog'] | 'cat' ]
  # tail

  # StringAndBinaries-4 - Page 123
  # (Hard) Write a function that takes a single-quoted string of the form number
  # [+-*/] number and returns the result of the calculation. The individual
  # numbers do not have leading plus or minus signs.
  # calculate('123 + 27') # => 150
  # def calculate(string) do
  #   [operand1, operator, operand2] = ~w[#{string}]
  #   op1 = String.to_integer(operand1)
  #   op2 = String.to_integer(operand2)
  #   case operator do
  #     "+" -> op1 + op2
  #     "-" -> op1 - op2
  #     "*" -> op1 * op2
  #     "/" -> div(op1, op2)
  #     _ -> :error
  #   end
  # end
  def calculate(charlist), do: _calculate(charlist, 0)

  defp _calculate([head | tail], value) when head in '0123456789' do
    _calculate(tail, value * 10 + head - ?0)
  end

  defp _calculate(float, 0) when is_float(float), do: float

  defp _calculate([head | tail], value) when head in '+-*/' do
    case head do
      ?+ -> value + _calculate(tail, 0)
      ?- -> value - _calculate(tail, 0)
      ?* -> value * _calculate(tail, 0)
      ?/ -> value / _calculate(tail, 0)
      _ -> :error
    end
  end

  defp _calculate([_head | tail], value), do: _calculate(tail, value)
  defp _calculate([], value), do: value

  # Test commands:
  # Chapter11.calculate('123 + 27')
  # Chapter11.calculate(2/4)

  # StringAndBinaries-5 - Page 130
  # Write a function that takes a list of double-quoted strings and prints each
  # on a separate line, centered in a column that has the width of the longest
  # string. Make sure it works with UTF characters.
  # iex> center(["cat", "zebra", "elephant"])
  #     cat
  #    zebra
  #   elephant

  def center(list) do
    longest = _find_longest(list, "")

    for item <- list do
      IO.puts(
        String.pad_leading(
          item,
          div(longest - String.length(item), 2) + String.length(item)
        )
      )
    end
  end

  defp _find_longest([head | tail], result) do
    if(String.length(head) >= String.length(result)) do
      _find_longest(tail, head)
    else
      _find_longest(tail, result)
    end
  end

  defp _find_longest([], result), do: String.length(result) + 1

  # Test commands:
  # Chapter11.center(["cat", "zebra", "elephant"])

  # StringAndBinaries-6 - Page 131
  # Write a function to capitalize the sentences in a string. Each sentence is
  # terminated by a period and a space. Right now, the case of the characters in
  # the string is random.
  # iex> capitalize_sentences("oh. a DOG. woof. ")
  # "Oh. A dog. Woof. "

  def capitalize_sentences(input) do
    sentences = String.split(String.downcase(input), ". ")

    sentence_case =
      for sentence <- sentences, sentence != "" do
        String.upcase(String.at(sentence, 0)) <>
          String.slice(sentence, 1..String.length(sentence)) <> ". "
      end

    Enum.join(sentence_case)
  end

  # Test commands:
  # Chapter11.capitalize_sentences("oh. a DOG. woof. ")

  # StringAndBinaries-7 - Page 131
  # Chapter 7 had an exercise about calculating sales tax on page 114.
  # We now have the sales information in a file of comma-separated id, ship_to,
  # and amount values. The file looks like this:
  #   id,ship_to,net_amount
  #   123,:NC,100.00
  #   124,:OK,35.50
  #   125,:TX,24.00
  #   126,:TX,44.80
  #   127,:NC,25.00
  #   128,:MA,10.00
  #   129,:CA,102.00
  #   120,:NC,50.00
  # Write a function that reads and parses this file and then passes the result
  # to the sales_tax function. Remember that the data should be formatted into a
  # keyword list, and that the fields need to be the correct types (so the id
  # field is an integer, and so on).
  # You’ll need the library functions File.open, IO.read(file, :line),
  # nd IO.stream(file).

  def parse(input) do
    data =
      [head | tail] =
      File.open!(input)
      |> IO.stream(:line)
      |> Enum.map(fn x -> String.split(String.trim(x), ",") end)
      |> Enum.map(fn [x, y, z] -> [id: x, ship_to: y, net_amount: z] end)

    Enum.map(tail, fn [id: v1, ship_to: v2, net_amount: v3] ->
      [
        id: String.to_integer(v1),
        ship_to: String.to_atom(String.slice(v2, 1..String.length(v2))),
        net_amount: String.to_float(v3)
      ]
    end)
  end

  def add_taxes(rates, orders) do
    for order <- orders, _rate <- rates do
      case order[:ship_to] do
        :NC ->
          [
            {:total_amount,
             order[:net_amount] +
               order[:net_amount] * rates[:NC]}
            | order
          ]

        :TX ->
          [
            {:total_amount,
             order[:net_amount] +
               order[:net_amount] * rates[:TX]}
            | order
          ]

        _ ->
          [{:total_amount, order[:net_amount]} | order]
      end
    end
  end

  # Test commands:
  # c("chapter_11.ex")
  # Chapter11.add_taxes([ NC: 0.075, TX: 0.08 ],Chapter11.parse("data.csv"))
end
