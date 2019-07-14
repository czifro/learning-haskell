module Chapter003.ListADT where
  data List a = Cons a (List a)
              | Nil
                deriving (Show)