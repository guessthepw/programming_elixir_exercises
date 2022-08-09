defmodule Chapter12 do
  # ControlFlow-1 Page 139
  # Rewrite the FizzBuzz example using case.

  def upto(n) when n > 0, do: _upto(1, n, [])
  defp _upto(_current, 0, result), do: Enum.reverse(result)

  defp _upto(current, left, result) do
    next_answer =
      case {rem(current, 3), rem(current, 5)} do
        {0, 0} -> "FizzBuzz"
        {0, _} -> "Fizz"
        {_, 0} -> "Buzz"
        {_, _} -> current
      end

    _upto(current + 1, left - 1, [next_answer | result])
  end

  # Test Command:
  # Chapter12.upto(20)

  # ControlFlow-2 Page 139
  # We now have three different implementations of FizzBuzz. One uses cond, one
  # uses case, and one uses separate functions with guard clauses. Take a minute
  # to look at all three.
  # Which do you feel best expresses the problem?
  # Which will be easiest to maintain?
  #
  # I think this implementation is the easiest to maintain.
  # def fizzbuzz({0,0,c}), do: "FizzBuzz"
  # def fizzbuzz({0,b,c}), do: "Fizz"
  # def fizzbuzz({a,0,c}), do: "Buzz"
  # def fizzbuzz({a,b,c}), do: c
  # I think the conditional best expresses the pattern, but not the most efficient
  # that may because of my past with OOP.

  # The case style and the implementation using guard clauses are different from
  # control structures in most other languages. If you feel that one of these was
  # the best implementation, can you think of ways to remind yourself to
  # investigate these options as you write Elixir code in the future?
  #
  # "DONT USE THE HAMMER JOHN - GIO"

  # ControlFlow-3 Page 140
  # Many built-in functions have two forms. The xxx form returns the tuple
  # {:ok, data} and the xxx! form returns data on success but raises an exception
  # otherwise. However, some functions don’t have the xxx! form.
  # Write an ok! function that takes an arbitrary parameter. If the parameter is
  # the tuple {:ok, data}, return the data. Otherwise, raise an exception
  # containing information from the parameter.
  # You could use your function like this:
  # file = ok! File.open("somefile")

  def ok!({:ok, data}), do: data
  def ok!({:error, msg}), do: msg

  # Test commands:
  # Chapter12.ok! File.open("chapter_12.ex")
  # Chapter12.ok! File.open("chapter_121.ex")
end
