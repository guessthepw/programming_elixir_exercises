defmodule Chapter10 do
  # ListAndRecursion-5 - Page 102
  # Implement the following Enum functions using no library functions or list
  # comprehensions: all?, each, filter, split, and take. You may need to use
  # an if statement to implement filter. The syntax for this is
  def all?([]), do: true
  def all?([head | _tail]) when head == nil, do: false
  def all?([head | tail]) when head != nil, do: all?(tail)
  # Test command:
  # Chapter10.all?([1,2,3])
  # Chapter10.all?([1, nil, 3])
  # Chapter10.all?([])

  def all?([], _function), do: true

  def all?([head | tail], function) do
    if(function.(head)) do
      all?(tail, function)
    else
      false
    end
  end
  # Test command:
  # Chapter10.all?([2, 4, 6], fn x -> rem(x, 2) == 0 end)
  # Chapter10.all?([2, 3, 4], fn x -> rem(x, 2) == 0 end)
  # Chapter10.all?([], fn _ -> nil end)

  def each([], _function), do: []

  def each([head | tail], function) do
    [function.(head) | each(tail, function)]
  end
  # Test commands:
  # Chapter10.each(["some", "example"], fn x -> IO.puts(x) end)

  def filter([], _function), do: []

  def filter([head | tail], function) do
    if(function.(head)) do
      [head | filter(tail, function)]
    else
      filter(tail, function)
    end
  end
  # Test commands:
  # Chapter10.filter([1, 2, 3], fn x -> rem(x, 2) == 0 end)

  def split([head | tail], count) when count > 0 do
    {left, right} = split(tail, count - 1)
    {[head | left], right}
  end

  def split([head | tail], count) when count < 0 do
    count = length([head | tail]) + count
    {left, right} = split(tail, count - 1)
    {[head | left], right}
  end

  def split(list, _count), do: {[], list}
  # Test commands:
  # Chapter10.split([1, 2, 3], 2)
  # Chapter10.split([1, 2, 3], 10)
  # Chapter10.split([1, 2, 3], 0)
  # Chapter10.split([1, 2, 3], -1)
  # Chapter10.split([1, 2, 3], -5)

  def take(list, count) when count > length(list) do
    take(list, length(list))
  end

  def take([head | tail], count) when count > 0 do
    [head | take(tail, count - 1)]
  end

  def take(list, count) when count < 0 do
    take(Chapter10.reverse(list), abs(count))
  end

  def take(_list, 0), do: []
  def take([], _count), do: []

  def reverse(list), do: reverse(list, [])
  def reverse([head | tail], list), do: reverse(tail, [head] ++ list)
  def reverse([], newlist), do: newlist
  # Test commands:
  # Chapter10.take([1, 2, 3], 2)
  # Chapter10.take([1, 2, 3], 10)
  # Chapter10.take([1, 2, 3], 0)
  # Chapter10.take([1, 2, 3], -1)

  # ListAndRecursion-6 - Page 102
  # Write a flatten(list) function that takes a list that may contain any
  # number of sublists, which themselves may contain sublists, to any depth.
  # It returns the elements of these lists as a flat list.
  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)
  def flatten([]), do: []
  def flatten(num) when is_integer(num), do: [num]
  # Test command
  # Chapter10.flatten([ 1, [ 2, 3, [4] ], 5, [[[6]]]])

  # ListAndRecursion-7 - Page 114
  # In the last exercise of Chapter 7, Lists and Recursion, on page 71, you
  # wrote a span function. Use it and list comprehensions to return a list of
  # the prime numbers from 2 to n.
  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from + 1, to)]

  def prime_numbers(upper_limit) do
    range = span(2,upper_limit)
    list = for number <- range, acc <- 2..div(upper_limit,2),
            number != acc, rem(number,acc) == 0, do: number
    range -- list
  end
  # Test command
  # Chapter10.prime_numbers(10)
  # Chapter10.prime_numbers(100)

  # ListAndRecursion-8 - Page 114
  # The Pragmatic Bookshelf has offices in Texas (TX) and North Carolina (NC),
  # so we have to charge sales tax on orders shipped to these states. The rates
  # can be expressed as a keyword list (I wish it were that simple....):
  # tax_rates = [ NC: 0.075, TX: 0.08 ]
  # Here’s a list of orders:
  # orders = [
  #     [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  #     [ id: 124, ship_to: :OK, net_amount:  35.50 ],
  #     [ id: 125, ship_to: :TX, net_amount:  24.00 ],
  #     [ id: 126, ship_to: :TX, net_amount:  44.80 ],
  #     [ id: 127, ship_to: :NC, net_amount:  25.00 ],
  #     [ id: 128, ship_to: :MA, net_amount:  10.00 ],
  #     [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  #     [ id: 130, ship_to: :NC, net_amount:  50.00 ] ]
  # Write a function that takes both lists and returns a copy of the orders, but
  # with an extra field, total_amount, which is the net plus sales tax. If a
  # shipment is not to NC or TX, there’s no tax applied.
  def add_taxes(rates, orders) do
    for order <- orders, _rate <- rates do
        case order[:ship_to] do
           :NC -> [ {:total_amount, order[:net_amount] +
                    order[:net_amount] * rates[:NC] } | order]
           :TX -> [ {:total_amount, order[:net_amount] +
                    order[:net_amount] * rates[:TX] } | order]
            _ -> [ {:total_amount, order[:net_amount] } | order]
        end
    end
  end
  # Test command
  # tax_rates = [ NC: 0.075, TX: 0.08 ]
  # orders = [
  #     [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  #     [ id: 124, ship_to: :OK, net_amount:  35.50 ],
  #     [ id: 125, ship_to: :TX, net_amount:  24.00 ],
  #     [ id: 126, ship_to: :TX, net_amount:  44.80 ],
  #     [ id: 127, ship_to: :NC, net_amount:  25.00 ],
  #     [ id: 128, ship_to: :MA, net_amount:  10.00 ],
  #     [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  #     [ id: 130, ship_to: :NC, net_amount:  50.00 ] ]
  # Chapter10.add_taxes(tax_rates,orders)
end
