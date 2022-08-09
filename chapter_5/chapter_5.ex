defmodule Chapter5 do
  # Functions-1 - Page 45
  # Go into IEx. Create and run the functions that do the following:
  
  # 1A – list_concat.([:a, :b],[:c, :d]) #=> [:a, :b, :c, :d]
  list_concat = fn(a, b) -> a ++ b end
  # Test command:  
  IO.inspect("************ Exercise 1A ************")
  IO.inspect(list_concat.([1,2], [3,4]))
     
  # 1B – sum.(1, 2, 3) #=> 6
  # def sum(a,b,c), do: a+b+c
  sum = fn(a, b, c) -> a + b + c end
  # Test command: 
  IO.inspect("************ Exercise 1B ************")
  IO.inspect(sum.(1, 2, 3))

  # 1C – pair_tuple_to_list.( { 1234, 5678 } ) #=> [ 1234, 5678 ]
  pair_tuple_to_list = fn({a, b}) -> [a, b] end
  # Test command: 
  IO.inspect("************ Exercise 1C ************")
  IO.inspect(pair_tuple_to_list.({:a, :b}))

  # Functions-2 - Page 45
  # Write a function that takes three arguments. If the first two are zero,
  # return “FizzBuzz.” If the first is zero, return “Fizz.” If the second 
  # is zero, return “Buzz.”  Otherwise return the third argument. Do not 
  # use any lan- guage features that we haven’t yet covered in this book.
  fizzbuzz = fn 
      {0, 0, _} -> "FizzBuzz"
      {0, _, _} -> "Fizz"
      {_, 0, _} -> "Buzz"
      {_, _, n} -> n
  end
  # Test commands:
  IO.inspect("************ Exercise 2 ************") 
  IO.inspect(fizzbuzz.({0, 0, 1}))
  IO.inspect(fizzbuzz.({0, 1, 1}))
  IO.inspect(fizzbuzz.({1, 0, 1}))
  IO.inspect(fizzbuzz.({1, 2, 3}))

  # Functions-3 - Page 47 
  # The operator rem(a, b) returns the remainder after dividing a by b.
  # Write a function that takes a single integer (n) and calls the function
  # in the previ- ous exercise, passing it rem(n,3), rem(n,5), and n. 
  # Call it seven times with the arguments 10, 11, 12, and so on. 
  # You should get “Buzz, 11, Fizz, 13, 14, FizzBuzz, 16.”
  call_fizzbuzz = fn(n) ->
      fizzbuzz.({rem(n, 3), rem(n, 5), n})
  end
  # Test commands:
  IO.inspect("************ Exercise 3 ************") 
  IO.inspect(call_fizzbuzz.(10))
  IO.inspect(call_fizzbuzz.(11))
  IO.inspect(call_fizzbuzz.(12))
  IO.inspect(call_fizzbuzz.(13))
  IO.inspect(call_fizzbuzz.(14))
  IO.inspect(call_fizzbuzz.(15))
  IO.inspect(call_fizzbuzz.(16))

  # Functions-4 Page 47 
  # Write a function prefix that takes a string. It should return a new 
  # function that takes a second string. When that second function is 
  # called, it will return a string containing the first string, a space
  # , and the second string.
  prefix = fn(prefix) -> (fn n -> "#{prefix} #{n} " end) end
  # Test commands:
  IO.inspect("************ Exercise 4 ************")
  IO.inspect(prefix = fn(prefix) -> (fn(n) -> "#{prefix} #{n} " end) end)
  IO.inspect(sir = prefix.("Sir"))
  IO.inspect(sir.("Jimmy")) 

  # Functions-5 - Page 50
  # Use the & Notation to rewrite the following:
  
  # 5A - Enum.map [1,2,3,4], fn x -> x + 2 end
  # Test command: 
  IO.inspect("************ Exercise 5A ************")
  IO.inspect(Enum.map([1, 2, 3, 4], &(&1 + 2)))

  # 5B - Enum.each [1,2,3,4], fn x -> IO.inspect x end
  # Test command:
  IO.inspect("************ Exercise 5B ************")
  Enum.each([1, 2, 3, 4], &(IO.inspect(&1)))
end
