{-# LANGUAGE OverloadedStrings #-}
module TodoBackend.Utils where

import           Network.HTTP.Types
import           Network.Wai
import           Network.Wai.Middleware.AddHeaders

allowCors :: Middleware
allowCors = addHeaders
  [ ("Access-Control-Allow-Origin" , "*")
  , ("Access-Control-Allow-Headers", "Accept, Content-Type")
  , ("Access-Control-Allow-Methods", "GET, HEAD, POST, DELETE, PUT, PATCH")
  ]

allowOptions :: Middleware
allowOptions app req resp = case requestMethod req of
  "OPTIONS" -> resp $ responseLBS status200 [] "ok"
  _         -> app req resp
