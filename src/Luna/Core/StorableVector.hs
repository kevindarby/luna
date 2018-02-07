{-# OPTIONS_GHC -ddump-simpl -ddump-to-file #-}
module Luna.Core.StorableVector where

import Prelude

import qualified Data.Vector.Storable as Vector hiding (length)
import           Data.Vector.Storable (Vector)
import qualified Data.Vector.Storable.Mutable as Vector
import           Data.Vector.Storable.Mutable (MVector, IOVector, STVector)

import Luna.Core.Data
import Luna.Core.Store
import Control.Monad (when)


mknodes_thawFreeze :: Int -> Vector (UniCore ()) -> IO (Vector (UniCore ()))
mknodes_thawFreeze !i !v = do
    nodes <- Vector.unsafeThaw v
    let go j = do
          x <- if j == 0 then return 0 else do
            pd <- Vector.unsafeRead nodes (j - 1)
            return $ fromSampleData pd
          Vector.unsafeWrite nodes j (mkSampleData (x+1) (x+1))
          when (j < i - 1) $ go (j + 1)
    go 0
    -- print =<< Vector.unsafeRead nodes (i - 1)
    Vector.unsafeFreeze nodes

mknodes2 :: Int -> StoreM' IO (UniCore ()) -> IO ()
mknodes2 !i !s = do
    let go 0 _  = return ()
        go j !v = do
            (v', (k :: Int)) <- reserveKey v
            unsafeWriteSpec v' k (mkSampleData j (j+1))
            go (j - 1) v'
    go i s
    return ()


mkVec :: Int -> IO (Vector (UniCore ()))
mkVec !i = Vector.unsafeFreeze =<< Vector.new (i + 1)


mkVecU :: Int -> IO (IOVector (UniCore ()))
mkVecU !i = Vector.unsafeNew (i + 1)