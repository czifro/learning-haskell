module Chapter003.Tuple where
  third (_, _, c) = c
  
  complicated (True, a, x:xs, 5) = (a, xs)