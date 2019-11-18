{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE TypeOperators     #-}
module Api where

import Data.Proxy
import Servant.API

import Models

type Api =
  "todos" :>
       ( Get '[JSON] [Todo] -- GET /todos
    :<|> Capture "id" Int :>
           ( Get '[JSON] (Maybe Todo) -- GET /todos/:id
        :<|> ReqBody '[JSON] Todo :> Patch '[JSON] (Maybe Todo) -- PATCH /todos/:id
        :<|> DeleteNoContent '[JSON] NoContent -- DELETE /todos/:id
           )
    :<|> ReqBody '[JSON] Todo :> Post '[JSON] Todo -- POST /todos
       )

api :: Proxy Api
api = Proxy