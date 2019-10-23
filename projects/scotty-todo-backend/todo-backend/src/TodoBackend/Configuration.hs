{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module TodoBackend.Configuration
  ( Config
  , serverConfig
  , getEnv'
  , serverPort
  , serverUrl
  , maybeServerPort
  , maybeServerUrl
  ) where

import           Control.Applicative
import           Control.Monad
import           Control.Monad.Trans.Maybe
import           Control.Monad.IO.Class
import           System.Environment

newtype Env a = Env { unEnv :: MaybeT IO a }
  deriving (Functor, Applicative, Monad, MonadIO, Alternative, MonadPlus)

getEnv' :: Env a -> IO (Maybe a)
getEnv' env = runMaybeT (unEnv env)

parser :: (String -> Maybe a) -> Maybe String -> Maybe a
parser parse m = parse =<< m

envAs :: String -> (String -> Maybe a) -> Env a
envAs key parse = Env (MaybeT (parser parse <$> lookupEnv key))

env :: String -> Env String
env key = envAs key Just

data Config = Config
  { serverPort   :: Int
  , serverUrl    :: String
  } deriving (Show, Eq)

serverConfig :: Env Config
serverConfig = Config
  <$> envAs "PORT" (Just . read)
  <*> env "URL"

maybeServerPort :: Maybe Config -> Int -> Int
maybeServerPort (Just c) _ = serverPort c
maybeServerPort _        p = p

maybeServerUrl :: Maybe Config -> String -> String
maybeServerUrl (Just c) _ = serverUrl c
maybeServerUrl _        u = u
