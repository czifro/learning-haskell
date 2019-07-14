module Chapter003.Exercises where
  (|>) x f = f x
  count :: [a] -> Int
  count (_:xs) = 1 + count xs
  count []     = 0
  
  mean (x:xs) = let _count = count (x:xs)
                    _sum   = sum (x:xs)
                in
                    _sum / (_count |> fromIntegral)
  mean []     = 0
  
  palindrome (x:xs) = [x] ++ palindrome xs ++ [x]
  palindrome []     = []
  
  isPalindrome (x:xs) = (x:xs) == reverse (x:xs)
  isPalindrome []     = True
  
  join _   (x:[]) = x
  join sep (x:xs) = x ++ [sep] ++ join sep xs
  join _   []     = []