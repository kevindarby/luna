{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE TemplateHaskell     #-}

module Data.Convert.Class where

import Prelude
import Control.Lens
import GHC.TypeLits
import Data.Default


--------------------------
-- === Convertibles === --
--------------------------

-- === Distinct types conversion === --

-- | Convertible allows for conversion between two compatible types.
--   When trying to convert between the same types, compile time error is reported in order to help tracking not needed usages.
--   If you want to enable conversion between the same types, use `convert'` instead.
class Convertible  t t' where convert  ::                        t                -> t'
class Convertible1 t t' where convert1 :: forall s1.             t s1             -> t' s1
class Convertible2 t t' where convert2 :: forall s1 s2.          t s1 s2          -> t' s1 s2
class Convertible3 t t' where convert3 :: forall s1 s2 s3.       t s1 s2 s3       -> t' s1 s2 s3
class Convertible4 t t' where convert4 :: forall s1 s2 s3 s4.    t s1 s2 s3 s4    -> t' s1 s2 s3 s4
class Convertible5 t t' where convert5 :: forall s1 s2 s3 s4 s5. t s1 s2 s3 s4 s5 -> t' s1 s2 s3 s4 s5


-- === Identity conversion errors === --

type IdConversionErr (t :: k) = 'Text "Conversion of the same type (`" ':<>: 'ShowType t ':<>: 'Text "`) is disabled by default. Please use convert' if you want to enable it."
instance TypeError (IdConversionErr t) => Convertible  t t where convert  = id ; {-# INLINE convert  #-}
instance TypeError (IdConversionErr t) => Convertible1 t t where convert1 = id ; {-# INLINE convert1 #-}
instance TypeError (IdConversionErr t) => Convertible2 t t where convert2 = id ; {-# INLINE convert2 #-}
instance TypeError (IdConversionErr t) => Convertible3 t t where convert3 = id ; {-# INLINE convert3 #-}
instance TypeError (IdConversionErr t) => Convertible4 t t where convert4 = id ; {-# INLINE convert4 #-}
instance TypeError (IdConversionErr t) => Convertible5 t t where convert5 = id ; {-# INLINE convert5 #-}


-- === Utils === --

convertTo  :: forall t' t. Convertible  t t' =>                        t                -> t'
convertTo1 :: forall t' t. Convertible1 t t' => forall s1.             t s1             -> t' s1
convertTo2 :: forall t' t. Convertible2 t t' => forall s1 s2.          t s1 s2          -> t' s1 s2
convertTo3 :: forall t' t. Convertible3 t t' => forall s1 s2 s3.       t s1 s2 s3       -> t' s1 s2 s3
convertTo4 :: forall t' t. Convertible4 t t' => forall s1 s2 s3 s4.    t s1 s2 s3 s4    -> t' s1 s2 s3 s4
convertTo5 :: forall t' t. Convertible5 t t' => forall s1 s2 s3 s4 s5. t s1 s2 s3 s4 s5 -> t' s1 s2 s3 s4 s5
convertTo  = convert  ; {-# INLINE convertTo  #-}
convertTo1 = convert1 ; {-# INLINE convertTo1 #-}
convertTo2 = convert2 ; {-# INLINE convertTo2 #-}
convertTo3 = convert3 ; {-# INLINE convertTo3 #-}
convertTo4 = convert4 ; {-# INLINE convertTo4 #-}
convertTo5 = convert5 ; {-# INLINE convertTo5 #-}


-- === Conversion allowing the same types === --

class Convertible'  t t' where convert'  ::                        t                -> t'
class Convertible1' t t' where convert1' :: forall s1.             t s1             -> t' s1
class Convertible2' t t' where convert2' :: forall s1 s2.          t s1 s2          -> t' s1 s2
class Convertible3' t t' where convert3' :: forall s1 s2 s3.       t s1 s2 s3       -> t' s1 s2 s3
class Convertible4' t t' where convert4' :: forall s1 s2 s3 s4.    t s1 s2 s3 s4    -> t' s1 s2 s3 s4
class Convertible5' t t' where convert5' :: forall s1 s2 s3 s4 s5. t s1 s2 s3 s4 s5 -> t' s1 s2 s3 s4 s5

instance {-# OVERLAPPING #-}  Convertible'  t t  where convert'  = id       ; {-# INLINE convert'  #-}
instance {-# OVERLAPPING #-}  Convertible1' t t  where convert1' = id       ; {-# INLINE convert1' #-}
instance {-# OVERLAPPING #-}  Convertible2' t t  where convert2' = id       ; {-# INLINE convert2' #-}
instance {-# OVERLAPPING #-}  Convertible3' t t  where convert3' = id       ; {-# INLINE convert3' #-}
instance {-# OVERLAPPING #-}  Convertible4' t t  where convert4' = id       ; {-# INLINE convert4' #-}
instance {-# OVERLAPPING #-}  Convertible5' t t  where convert5' = id       ; {-# INLINE convert5' #-}
instance Convertible  t t' => Convertible'  t t' where convert'  = convert  ; {-# INLINE convert'  #-}
instance Convertible1 t t' => Convertible1' t t' where convert1' = convert1 ; {-# INLINE convert1' #-}
instance Convertible2 t t' => Convertible2' t t' where convert2' = convert2 ; {-# INLINE convert2' #-}
instance Convertible3 t t' => Convertible3' t t' where convert3' = convert3 ; {-# INLINE convert3' #-}
instance Convertible4 t t' => Convertible4' t t' where convert4' = convert4 ; {-# INLINE convert4' #-}
instance Convertible5 t t' => Convertible5' t t' where convert5' = convert5 ; {-# INLINE convert5' #-}

convertTo'  :: forall t' t. Convertible'  t t' =>                        t                -> t'
convertTo1' :: forall t' t. Convertible1' t t' => forall s1.             t s1             -> t' s1
convertTo2' :: forall t' t. Convertible2' t t' => forall s1 s2.          t s1 s2          -> t' s1 s2
convertTo3' :: forall t' t. Convertible3' t t' => forall s1 s2 s3.       t s1 s2 s3       -> t' s1 s2 s3
convertTo4' :: forall t' t. Convertible4' t t' => forall s1 s2 s3 s4.    t s1 s2 s3 s4    -> t' s1 s2 s3 s4
convertTo5' :: forall t' t. Convertible5' t t' => forall s1 s2 s3 s4 s5. t s1 s2 s3 s4 s5 -> t' s1 s2 s3 s4 s5
convertTo'  = convert'  ; {-# INLINE convertTo'  #-}
convertTo1' = convert1' ; {-# INLINE convertTo1' #-}
convertTo2' = convert2' ; {-# INLINE convertTo2' #-}
convertTo3' = convert3' ; {-# INLINE convertTo3' #-}
convertTo4' = convert4' ; {-# INLINE convertTo4' #-}
convertTo5' = convert5' ; {-# INLINE convertTo5' #-}



----------------------------------
-- === Partial convertibles === --
----------------------------------

-- === Errors === --

data SimpleConversionError = SimpleConversionError deriving (Show)
instance Default SimpleConversionError where def = SimpleConversionError ; {-# INLINE def #-}


-- === Classes === --

-- | PartialConvertible allows conversions that could fail with `ConversionError`.
class PartialConvertible t t' where
    type family ConversionError t t'
    convertAssert :: t -> Maybe (ConversionError t t')
    unsafeConvert :: t -> t'

defConvertAssert :: Default e => (a -> Bool) -> a -> Maybe e
defConvertAssert f = \s -> if f s then Just def else Nothing

convertAssertTo :: forall t' t. PartialConvertible t t' => t -> Maybe (ConversionError t t')
convertAssertTo = convertAssert @t @t' ; {-# INLINE convertAssertTo #-}

maybeConvert :: forall t t'. PartialConvertible t t' => t -> Maybe t'
maybeConvert t = const (unsafeConvert t) <$> convertAssertTo @t' t ; {-# INLINE maybeConvert #-}

tryConvert :: forall t t'. PartialConvertible t t' => t -> Either (ConversionError t t') t'
tryConvert t = maybe (Right $ unsafeConvert t) Left $ convertAssertTo @t' t ; {-# INLINE tryConvert #-}



-----------------------------
-- === Bi-convertibles === --
-----------------------------

type BiConvertible  t t' = (Convertible  t t', Convertible  t' t)
type BiConvertible1 t t' = (Convertible1 t t', Convertible1 t' t)
type BiConvertible2 t t' = (Convertible2 t t', Convertible2 t' t)
type BiConvertible3 t t' = (Convertible3 t t', Convertible3 t' t)
type BiConvertible4 t t' = (Convertible4 t t', Convertible4 t' t)
type BiConvertible5 t t' = (Convertible5 t t', Convertible5 t' t)

type BiConvertible'  t t' = (Convertible'  t t', Convertible'  t' t)
type BiConvertible1' t t' = (Convertible1' t t', Convertible1' t' t)
type BiConvertible2' t t' = (Convertible2' t t', Convertible2' t' t)
type BiConvertible3' t t' = (Convertible3' t t', Convertible3' t' t)
type BiConvertible4' t t' = (Convertible4' t t', Convertible4' t' t)
type BiConvertible5' t t' = (Convertible5' t t', Convertible5' t' t)

type BiPartialConvertible t t' = (PartialConvertible t t', PartialConvertible t t')

converted   :: BiConvertible   t t' =>                        Iso' t                  t'
converted1  :: BiConvertible1  t t' => forall s1.             Iso' (t s1)             (t' s1)
converted2  :: BiConvertible2  t t' => forall s1 s2.          Iso' (t s1 s2)          (t' s1 s2)
converted3  :: BiConvertible3  t t' => forall s1 s2 s3.       Iso' (t s1 s2 s3)       (t' s1 s2 s3)
converted4  :: BiConvertible4  t t' => forall s1 s2 s3 s4.    Iso' (t s1 s2 s3 s4)    (t' s1 s2 s3 s4)
converted5  :: BiConvertible5  t t' => forall s1 s2 s3 s4 s5. Iso' (t s1 s2 s3 s4 s5) (t' s1 s2 s3 s4 s5)
converted'  :: BiConvertible'  t t' =>                        Iso' t                  t'
converted1' :: BiConvertible1' t t' => forall s1.             Iso' (t s1)             (t' s1)
converted2' :: BiConvertible2' t t' => forall s1 s2.          Iso' (t s1 s2)          (t' s1 s2)
converted3' :: BiConvertible3' t t' => forall s1 s2 s3.       Iso' (t s1 s2 s3)       (t' s1 s2 s3)
converted4' :: BiConvertible4' t t' => forall s1 s2 s3 s4.    Iso' (t s1 s2 s3 s4)    (t' s1 s2 s3 s4)
converted5' :: BiConvertible5' t t' => forall s1 s2 s3 s4 s5. Iso' (t s1 s2 s3 s4 s5) (t' s1 s2 s3 s4 s5)
converted   = iso convert   convert   ; {-# INLINE converted   #-}
converted1  = iso convert1  convert1  ; {-# INLINE converted1  #-}
converted2  = iso convert2  convert2  ; {-# INLINE converted2  #-}
converted3  = iso convert3  convert3  ; {-# INLINE converted3  #-}
converted4  = iso convert4  convert4  ; {-# INLINE converted4  #-}
converted5  = iso convert5  convert5  ; {-# INLINE converted5  #-}
converted'  = iso convert'  convert'  ; {-# INLINE converted'  #-}
converted1' = iso convert1' convert1' ; {-# INLINE converted1' #-}
converted2' = iso convert2' convert2' ; {-# INLINE converted2' #-}
converted3' = iso convert3' convert3' ; {-# INLINE converted3' #-}
converted4' = iso convert4' convert4' ; {-# INLINE converted4' #-}
converted5' = iso convert5' convert5' ; {-# INLINE converted5' #-}

convertedTo   :: BiConvertible   t' t =>                        Iso' t                  t'
convertedTo1  :: BiConvertible1  t' t => forall s1.             Iso' (t s1)             (t' s1)
convertedTo2  :: BiConvertible2  t' t => forall s1 s2.          Iso' (t s1 s2)          (t' s1 s2)
convertedTo3  :: BiConvertible3  t' t => forall s1 s2 s3.       Iso' (t s1 s2 s3)       (t' s1 s2 s3)
convertedTo4  :: BiConvertible4  t' t => forall s1 s2 s3 s4.    Iso' (t s1 s2 s3 s4)    (t' s1 s2 s3 s4)
convertedTo5  :: BiConvertible5  t' t => forall s1 s2 s3 s4 s5. Iso' (t s1 s2 s3 s4 s5) (t' s1 s2 s3 s4 s5)
convertedTo'  :: BiConvertible'  t' t =>                        Iso' t                  t'
convertedTo1' :: BiConvertible1' t' t => forall s1.             Iso' (t s1)             (t' s1)
convertedTo2' :: BiConvertible2' t' t => forall s1 s2.          Iso' (t s1 s2)          (t' s1 s2)
convertedTo3' :: BiConvertible3' t' t => forall s1 s2 s3.       Iso' (t s1 s2 s3)       (t' s1 s2 s3)
convertedTo4' :: BiConvertible4' t' t => forall s1 s2 s3 s4.    Iso' (t s1 s2 s3 s4)    (t' s1 s2 s3 s4)
convertedTo5' :: BiConvertible5' t' t => forall s1 s2 s3 s4 s5. Iso' (t s1 s2 s3 s4 s5) (t' s1 s2 s3 s4 s5)
convertedTo   = converted   ; {-# INLINE convertedTo   #-}
convertedTo1  = converted1  ; {-# INLINE convertedTo1  #-}
convertedTo2  = converted2  ; {-# INLINE convertedTo2  #-}
convertedTo3  = converted3  ; {-# INLINE convertedTo3  #-}
convertedTo4  = converted4  ; {-# INLINE convertedTo4  #-}
convertedTo5  = converted5  ; {-# INLINE convertedTo5  #-}
convertedTo'  = converted'  ; {-# INLINE convertedTo'  #-}
convertedTo1' = converted1' ; {-# INLINE convertedTo1' #-}
convertedTo2' = converted2' ; {-# INLINE convertedTo2' #-}
convertedTo3' = converted3' ; {-# INLINE convertedTo3' #-}
convertedTo4' = converted4' ; {-# INLINE convertedTo4' #-}
convertedTo5' = converted5' ; {-# INLINE convertedTo5' #-}



-- === ConvertVia === --

type ConvertVia  t p t' = (Convertible  t p, Convertible  p t')
type ConvertVia1 t p t' = (Convertible1 t p, Convertible1 p t')
type ConvertVia2 t p t' = (Convertible2 t p, Convertible2 p t')
type ConvertVia3 t p t' = (Convertible3 t p, Convertible3 p t')
type ConvertVia4 t p t' = (Convertible4 t p, Convertible4 p t')
type ConvertVia5 t p t' = (Convertible5 t p, Convertible5 p t')

convertVia  :: forall p t t'. ConvertVia  t p t' =>                        t                -> t'
convertVia1 :: forall p t t'. ConvertVia1 t p t' => forall s1.             t s1             -> t' s1
convertVia2 :: forall p t t'. ConvertVia2 t p t' => forall s1 s2.          t s1 s2          -> t' s1 s2
convertVia3 :: forall p t t'. ConvertVia3 t p t' => forall s1 s2 s3.       t s1 s2 s3       -> t' s1 s2 s3
convertVia4 :: forall p t t'. ConvertVia4 t p t' => forall s1 s2 s3 s4.    t s1 s2 s3 s4    -> t' s1 s2 s3 s4
convertVia5 :: forall p t t'. ConvertVia5 t p t' => forall s1 s2 s3 s4 s5. t s1 s2 s3 s4 s5 -> t' s1 s2 s3 s4 s5
convertVia  = convert  . convertTo  @p ; {-# INLINE convertVia #-}
convertVia1 = convert1 . convertTo1 @p ; {-# INLINE convertVia1 #-}
convertVia2 = convert2 . convertTo2 @p ; {-# INLINE convertVia2 #-}
convertVia3 = convert3 . convertTo3 @p ; {-# INLINE convertVia3 #-}
convertVia4 = convert4 . convertTo4 @p ; {-# INLINE convertVia4 #-}
convertVia5 = convert5 . convertTo5 @p ; {-# INLINE convertVia5 #-}

type ConvertVia'  t p t' = (Convertible'  t p, Convertible'  p t')
type ConvertVia1' t p t' = (Convertible1' t p, Convertible1' p t')
type ConvertVia2' t p t' = (Convertible2' t p, Convertible2' p t')
type ConvertVia3' t p t' = (Convertible3' t p, Convertible3' p t')
type ConvertVia4' t p t' = (Convertible4' t p, Convertible4' p t')
type ConvertVia5' t p t' = (Convertible5' t p, Convertible5' p t')

convertVia'  :: forall p t t'. ConvertVia'  t p t' =>                        t                -> t'
convertVia1' :: forall p t t'. ConvertVia1' t p t' => forall s1.             t s1             -> t' s1
convertVia2' :: forall p t t'. ConvertVia2' t p t' => forall s1 s2.          t s1 s2          -> t' s1 s2
convertVia3' :: forall p t t'. ConvertVia3' t p t' => forall s1 s2 s3.       t s1 s2 s3       -> t' s1 s2 s3
convertVia4' :: forall p t t'. ConvertVia4' t p t' => forall s1 s2 s3 s4.    t s1 s2 s3 s4    -> t' s1 s2 s3 s4
convertVia5' :: forall p t t'. ConvertVia5' t p t' => forall s1 s2 s3 s4 s5. t s1 s2 s3 s4 s5 -> t' s1 s2 s3 s4 s5
convertVia'  = convert'  . convertTo'  @p ; {-# INLINE convertVia' #-}
convertVia1' = convert1' . convertTo1' @p ; {-# INLINE convertVia1' #-}
convertVia2' = convert2' . convertTo2' @p ; {-# INLINE convertVia2' #-}
convertVia3' = convert3' . convertTo3' @p ; {-# INLINE convertVia3' #-}
convertVia4' = convert4' . convertTo4' @p ; {-# INLINE convertVia4' #-}
convertVia5' = convert5' . convertTo5' @p ; {-# INLINE convertVia5' #-}



-- !!!!!!!!!!!!!!!!!!!!!!!! DEPRECATED

-- === Casts === --

-- FIXME: Depreciated
class Castable a b where
    cast :: a -> b
    default cast :: Convertible a b => a -> b
    cast = convert ; {-# INLINE cast #-}
