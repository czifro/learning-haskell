module Chapter004.IntParse where

  import Data.Char

  loop :: Int -> String -> Int
  loop acc [] = acc
  loop acc (x:xs) = let acc' = acc * 10 + digitToInt x
                    in loop acc' xs

  asInt :: String -> Int
  asInt xs = loop 0 xs
  