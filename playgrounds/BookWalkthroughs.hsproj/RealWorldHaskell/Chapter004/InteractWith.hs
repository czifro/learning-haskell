module Chapter004.InteractWith where

--  import System.Environment (getArgs)
  import Control.Monad
  
  interactWith function inputFile outputFile = do
    input <- readFile inputFile
    writeFile outputFile (function input)
    
  toIO :: [String] -> IO [String]
  toIO str = return str
    
  main0 args = mainWith myFunction
    where mainWith function = do
--          interactWith function "hello-in.txt" "hello-out.txt"
            args <- toIO args-- ["hello-in.txt", "hello-out.txt"] -- getArgs
            case args of
              [input, output] -> interactWith function input output
              _ -> putStrLn "error: exectly two arguments needed"
          
          myFunction = id