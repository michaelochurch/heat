module Heat.RDD where

-- This will evolve into a megaclass... and then I will have to refactor it.
class RDD r where
  rMap      :: (a -> b) -> r a -> r b
  rFilter   :: (a -> Bool) -> r a -> r a
  rFlatMap  :: (a -> [b]) -> r a -> r b
  rCount    :: r a -> Integer

-- Silly instance that probably won't live long. Neither R nor D...
instance RDD [] where
  rMap     = map
  rFilter  = filter
  rFlatMap = concatMap
  rCount   = fromIntegral . length
