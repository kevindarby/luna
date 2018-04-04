{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE UndecidableInstances      #-}
{-# EXT      InlineAll                 #-}

module Luna.Syntax.Text.Parser.Marker where

import Prologue hiding (Span, String, Type, span)

import Text.Megaparsec.Prim (MonadParsec)
import Type.Any             (AnyType)

-- import OCI.IR hiding (IRBuilder, get)
import qualified Control.Monad.State.Layered as State

import Data.Text.Position
import Luna.Syntax.Text.Layer.Loc

import           Data.Map               (Map)
import qualified Data.Map               as Map
import qualified Luna.Syntax.Text.Lexer as Lexer



---------------------------------------
-- === Marker expression mapping === --
---------------------------------------

-- === Definition === --

-- type MarkerId = Word64
-- newtype MarkedExprMap = MarkedExprMap (Map MarkerId SomeExpr) deriving (Show, Mempty, Default)
-- newtype UnmarkedExprs = UnmarkedExprs [SomeExpr]              deriving (Show, Mempty, Default)
-- makeLenses ''MarkedExprMap
-- makeLenses ''UnmarkedExprs


-- === Utils === --

-- addMarkedExpr :: MonadState MarkedExprMap m => MarkerId -> SomeExpr -> m ()
-- addMarkedExpr gid expr = State.modify_ @MarkedExprMap $ wrapped . at gid .~ Just expr

-- addUnmarkedExpr :: MonadState UnmarkedExprs m => SomeExpr -> m ()
-- addUnmarkedExpr expr = State.modify_ @UnmarkedExprs $ wrapped %~ (expr :)


-- -------------------------
-- -- === TokenMarker === --
-- -------------------------

-- -- === Definition === --

-- type MarkerToken = Lexer.Token MarkerId
-- data MarkerState = MarkerState { _lastTokenMarker :: Maybe MarkerToken
--                                , _allMarkers      :: [MarkerId]
--                                } deriving (Show)
-- makeLenses ''MarkerState


-- -- === Utils === --

-- cleanLastTokenMarker :: MonadState MarkerState m => m ()
-- cleanLastTokenMarker = State.modify_ @MarkerState $ lastTokenMarker .~ Nothing

-- newLastTokenMarker :: MonadState MarkerState m => MarkerToken -> m ()
-- newLastTokenMarker m = State.modify_ @MarkerState $ \s -> s & lastTokenMarker .~ Just m
--                                                       & allMarkers      %~ (m ^. Lexer.element :)

-- getLastTokenMarker :: MonadState MarkerState m => m (Maybe MarkerToken)
-- getLastTokenMarker = view lastTokenMarker <$> get @MarkerState

-- useLastTokenMarker :: MonadState MarkerState m => m (Maybe MarkerToken)
-- useLastTokenMarker = getLastTokenMarker <* cleanLastTokenMarker


-- -- === Instances === --

-- instance Default MarkerState where def = MarkerState def def