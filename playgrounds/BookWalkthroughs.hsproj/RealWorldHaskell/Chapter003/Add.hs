module Chapter003.Add where
  sumList (x:xs) = x + sumList xs
  sumList []     = 0