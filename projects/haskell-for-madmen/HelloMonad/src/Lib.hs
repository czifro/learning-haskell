module Lib
  ( greetPerson
  ) where

greet :: String -> String
greet name = "Hello " ++ name ++ ", I am monad."

greetPerson :: IO ()
-- greetPerson =
--     fmap greet getLine >>= putStrLn
greetPerson =
  do
    putStrLn "I am monad, what is your name?"
    personName <- getLine
    putStrLn ("Hello, " ++ personName ++ "! What shall we *do* together?")
