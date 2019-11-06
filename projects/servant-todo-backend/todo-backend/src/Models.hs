module Models
  ( Todo (..)
  , Id (..)
  , UpdatableTodo (..)
  )
  where

import           Data.Int                       ( Int64 )

newtype Id a = Id Int64 deriving (Eq, Read)

data Todo = Todo
  { todoId        :: Id Todo
  , todoTitle     :: String
  , todoCompleted :: Bool
  , todoOrder     :: Int
  } deriving (Eq, Read)

data UpdatableTodo = UpdatableTodo
  { updatedTitle :: Maybe String
  , updatedCompleted :: Maybe Bool
  , updatedOrder :: Maybe Int
  } deriving (Eq, Read)