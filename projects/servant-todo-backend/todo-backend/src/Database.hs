{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE QuasiQuotes       #-}
module Database where

import           Control.Monad                  ( mapM_ )
import           Control.Applicative
import           Data.Int                       ( Int64 )
import           Data.Maybe                     ( listToMaybe )
import           Data.Text                      ( Text )
import qualified Data.Text                     as T
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow
import           Database.SQLite.Simple.FromField
import           Database.SQLite.Simple.ToField
import           Database.SQLite.Simple.Internal
import           Database.SQLite.Simple.Ok
import           Database.SQLite.Simple.QQ

import           Models

instance FromField (Id Todo) where
  fromField (Field (SQLInteger id) _) = Ok (Id id)
  fromField f = returnError ConversionFailed f "Not a valid id"

instance ToField (Id Todo) where
  toField (Id id) = SQLInteger id

instance FromRow Todo where
  fromRow = Todo <$> field <*> field <*> field <*> field

instance ToRow Todo where
  toRow (Todo _tId tTitle tCompleted tOrder) = toRow(tTitle, tCompleted, tOrder)

newtype DbConfig = DbConfig
  { connectionString :: String
  } deriving (Show)

createConn :: DbConfig -> IO Connection
createConn cnf = open $ connectionString cnf

runDb :: DbConfig -> (Connection -> IO a) -> IO a
runDb cnf query = do
  conn <- createConn cnf
  query conn

migrateDb :: DbConfig -> IO ()
migrateDb cnf = runDb cnf createTable
  where
    createTable :: Connection -> IO ()
    createTable conn = execute_ conn stmt
      where
        stmt = [sql|
          create table if not exists todos (
            id integer primary key autoincrement,
            title text,
            completed bool,
            order integer
          )
        |]

fetchTodo :: Id Todo -> DbConfig -> IO (Maybe Todo)
fetchTodo tId cnf = listToMaybe <$> runDb cnf queryTodo
  where
    queryTodo :: Connection -> IO [Todo]
    queryTodo conn = query conn [sql|
        select
          *
        from
          todos
        where id = ?
      |] (Only tId)

updateTodo :: Int -> UpdatableTodo -> DbConfig -> IO ()
updateTodo id (UpdatableTodo uTitle uCompleted uOrder) cnf = runDb cnf updateTodo'
  where
    updateTodo' :: Connection -> IO ()
    updateTodo' conn =
      let (updateTitleStmt, updateTitleParam) =
        uTitle >> fmap
        -- case uTitle of
        -- Nothing -> "", []
        -- Just t -> "title = ?", [Only t]