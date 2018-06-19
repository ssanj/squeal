module Types (BreachedAccounts(..),
              BreachedAccount(..),
              Breach(..),
              PasswordHash(..),
              Hash(..),
              Email(..)
              ) where

import qualified Data.Text as T
import qualified Data.ByteString as B
import Data.Aeson
import Data.Aeson.Types (typeMismatch)

data BreachedAccount =
  BreachedAccount { name :: !T.Text } deriving Show

data BreachedAccounts =
  BreachedAccounts { accounts :: [BreachedAccount] } deriving Show

-- data Service = Breach Email | PasswordHash Hash
data Breach = Breach Email
data PasswordHash = PasswordHash Hash

data Email = Email T.Text

data Hash = Hash { prefix :: !B.ByteString, suffix :: !B.ByteString }

instance FromJSON BreachedAccount where
  parseJSON (Object v)  = BreachedAccount <$> v .: (T.pack "Name")
  parseJSON other = typeMismatch "BreachedAccount" other

instance FromJSON BreachedAccounts where
  parseJSON v = BreachedAccounts <$> (parseJSONList v)