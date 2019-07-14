module Chapter001.GettingStarted where

  add = 2 + 2
  power = 313 ^ 15
  --multiplyNeg = 2*-3 -- compiler error
  multiplyNeg = 2 * (-3)
  _main = putStrLn "Hello World"
  e = exp 1
  _seq = [1, 2, 3]
  _range = [1..10]
  _rangeInSteps = [0,2..10]

  __main = interact wordCount
    where wordCount input = show (length (lines input)) ++ "\n"