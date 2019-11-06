{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE TypeOperators     #-}
module Api where

import Data.Proxy
import Data.Import
import Servant.API

import Models

type Api =
  "todos" :>
       ( Get '[JSON] [Todo] -- GET /todos
    :<|> Capture "id" Int64 :>
           ( Get '[JSON] (Maybe Todo) -- GET /todos/:id
        :<|> ReqBody '[JSON] Todo :> Patch '[JSON] (Maybe Todo) -- PATCH /todos/:id
        :<|> DeleteNoContent '[JSON] NoContent -- DELETE /todos/:id
           )
         ReqBody '[JSON] Todo :> Post '[JSON] Todo -- POST /todos
       )

api :: Proxy Api
api = Proxy