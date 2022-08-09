defmodule Chapter6 do
  # ModulesAndFunctions-1 - Page 55
  # Extend the Times module with a triple function that multiplies its
  # parameter by three.
  defmodule Times1 do
    def double(n), do: n * 2

    def triple(n), do: n * 3
  end
  # Test command:
  # Chapter6.Times1.triple(2)

  # ModulesAndFunctions-2 - Page 55
  # Run the result in IEx. Use both techniques to compile the file.
  # Test command: c("chapter_6.ex") | iex "chapter_6.ex"

  # ModulesAndFunctions-3 - Page 55
  # Add a quadruple function. (Maybe it could call the double function....)
  defmodule Times3 do
    def double(n), do: n * 2

    def triple(n), do: n * 3

    def quadrouple(n), do: double(double(n))
  end
  # Test command:
  # Chapter6.Times3.quadrouple(2)

  # ModulesAndFunctions-4 - Page 57
  # Implement and run a function sum(n) that uses recursion to calculate
  # the sum of the integers from 1 to n. You’ll need to write this function
  # inside a module in a separate file. Then load up IEx, compile that file,
  # and try your function.
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)
  # Test commands:
  # Chapter6.sum(10)
  # Chapter6.sum(3)

  # ModulesAndFunctions-5 - Page 57
  # Write a function gcd(x,y) that finds the greatest common divisor
  # between two nonnegative integers. Algebraically, gcd(x,y) is x if y
  # is zero; it’s gcd(y, rem(x,y)) otherwise.
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
  # Test commands:
  # Chapter6.gcd(3,5)
  # Chapter6.gcd(25,100)

  # ModulesAndFunctions-6 - Page 62
  # I’m thinking of a number between 1 and 1000....
  # The most efficient way to find the number is to guess halfway between
  # the low and high numbers of the range. If our guess is too big, then
  # the answer lies between the bottom of the range and one less than our
  # guess. If our guess is too small, then the answer lies between one
  # more than our guess and the end of the range.
  def guess(actual, first..last) when actual in first..last do
    guess = div(first + last, 2)
    IO.puts("Is it #{guess}?")
    guess(actual, guess, first..last)
  end
  def guess(actual, guess, first.._last) when guess > actual do
    guess(actual, first..(guess - 1))
  end
  def guess(actual, guess, _first..last) when guess < actual do
    guess(actual, (guess + 1)..last)
  end
  def guess(actual, guess, _) when guess == actual do
    "Yes it is #{guess}, See we match #{actual}!"
  end
  # Test commands:
  # Chapter6.guess(273, 1..1000)
end
