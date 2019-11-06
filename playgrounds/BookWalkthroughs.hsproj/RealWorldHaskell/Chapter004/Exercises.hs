module Chapter004.Exercises where

  import Data.Char

  asInt_fold :: String -> Int
  asInt_fold [] = 0
  asInt_fold xs = foldl step 0 xs
    where step acc x = acc * 10 + digitToInt x