module Chapter004.Fold
  (_foldl) where
  
  _foldl :: (a -> b -> a) -> a -> [b] -> a
  _foldl step zero (x:xs) = foldl step (step zero x) xs
  _foldl _    zero []     = zero
  
  _foldr :: (a -> b -> b) -> b -> [a] -> b
  _foldr step zero (x:xs) = step x (_foldr step zero xs)
  _foldr _    zero []     = zero
  
--  _filter :: (a -> Bool) 