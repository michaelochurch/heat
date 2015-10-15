{-# LANGUAGE ExistentialQuantification #-}

module Heat.RDD where

import Prelude hiding (map, filter)
import qualified Prelude

data RDD a = FromFile [a] | forall b. MappedRDD (b -> a) (RDD b) |
             FilteredRDD (a -> Bool) (RDD a)

collect :: RDD a -> [a]
collect rdd =
  case rdd of
   FromFile strs     -> strs
   MappedRDD f rdd   -> Prelude.map f (collect rdd)
   FilteredRDD f rdd -> Prelude.filter f (collect rdd)

count :: RDD a -> Int
count = length . collect

map :: (a -> b) -> RDD a -> RDD b
map = MappedRDD

filter :: (a -> Bool) -> RDD a -> RDD a
filter = FilteredRDD
