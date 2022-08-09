defmodule Chapter7 do
  # ListAndRecursion-1 - Page 77
  # Write a mapsum function that takes a list and a function.
  # It applies the function to each element of the list and then sums
  # the result.
  def mapsum([], _func), do: []
  def mapsum([head | []], func), do: func.(head)
  def mapsum([head | tail], function) do
    function.(head) + mapsum([hd(tail) | tl(tail)], function)
  end
  # Test commands:
  # Chapter7.mapsum([1, 2, 3], &(&1 * &1))

  # ListAndRecursion-2 - Page 77
  # Write a max(list) that returns the element with the maximum value
  # in the list. (This is slightly trickier than it sounds.)
  # Note: Thinking there should be a way to do this with reduce,
  # took the easy way out.
  def max([]), do: []
  def max([head | []]), do: head
  def max([head | tail]) when head > hd(tail), do: max([head | tl(tail)])
  def max([head | tail]) when head <= hd(tail), do: max([hd(tail) | tl(tail)])
  # Test commands:
  # Chapter7.max([1,2,3,4])
  # Chapter7.max([1,22,3,4])
  # Chapter7.max([101,22,3,4])

  # ListAndRecursion-3 - Page 78
  # An Elixir single-quoted string is actually a list of individual character
  # codes. Write a caesar(list, n) function that adds n to each list element,
  # wrapping if the addition results in a character greater than z.
  def caesar([], _n), do: []
  def caesar([head | tail], n) when head + n > ?z do
    [(head + n) - 26 | caesar(tail, n)]
  end
  def caesar([head | tail], n) when head + n <= ?z do
    [(head + n) | caesar(tail, n)]
  end
  # Test commands:
  # Chapter7.caesar('ryvkve', 13)

  # ListAndRecursion-4 - Page 81
  # Write a function MyList.span(from, to) that returns a list of the numbers
  # from from up to to.
  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from + 1, to)]
  # Test commands:
  # Chapter7.span(25,30)
end
