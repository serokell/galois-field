module GaloisField
  ( GaloisField(..)
  ) where

import Protolude

import Control.Monad.Random (MonadRandom, Random)
import Test.Tasty.QuickCheck (Arbitrary)
import Text.PrettyPrint.Leijen.Text (Pretty)

-------------------------------------------------------------------------------
-- Galois field class
-------------------------------------------------------------------------------

-- | Galois fields @GF(p^q)@ for @p@ prime and @q@ non-negative.
class (Arbitrary k, Eq k, Fractional k, Generic k,
       NFData k, Pretty k, Random k, Read k, Show k) => GaloisField k where
  {-# MINIMAL char, deg, frob, pow, quad, rnd, sr #-}

  -- Characteristics

  -- | Characteristic @p@ of field and order of prime subfield.
  char :: k -> Integer

  -- | Degree @q@ of field as extension field over prime subfield.
  deg :: k -> Int

  -- | Order @p^q@ of field.
  order :: k -> Integer
  order = (^) <$> char <*> deg
  {-# INLINE order #-}

  -- | Frobenius endomorphism @x->x^p@ of prime subfield.
  frob :: k -> k

  -- Functions

  -- | Exponentiation of a field element to an integer.
  pow :: k -> Integer -> k

  -- | Solve quadratic @ax^2+bx+c=0@ over field.
  quad :: k -> k -> k -> Maybe k

  -- | Randomised field element.
  rnd :: MonadRandom m => m k

  -- | Square root of a field element.
  sr :: k -> Maybe k
