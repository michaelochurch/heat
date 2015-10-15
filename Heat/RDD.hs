{-# LANGUAGE ExistentialQuantification #-}

module Heat.RDD where

import Prelude hiding (map, filter)
import qualified Prelude

data RDD a = FromFile String [a] | forall b. MappedRDD (b -> a) (RDD b) |
             FilteredRDD (a -> Bool) (RDD a)

instance Show (RDD a) where
  show (FromFile filename _)   = "<RDD from file " ++ filename ++ ">"
  show (MappedRDD   _ rdd)     = "<MappedRDD around " ++ (show rdd) ++ ">"
  show (FilteredRDD _ rdd)     = "<FilteredRDD around " ++ (show rdd) ++ ">"

                               
collect :: RDD a -> [a]
collect rdd =
  case rdd of
   FromFile _ strs   -> strs
   MappedRDD f rdd   -> Prelude.map f (collect rdd)
   FilteredRDD f rdd -> Prelude.filter f (collect rdd)

count :: RDD a -> Int
count = length . collect

map :: (a -> b) -> RDD a -> RDD b
map f (MappedRDD g rdd) = MappedRDD (f . g) rdd
map f rdd = MappedRDD f rdd

(&&.) f g x = f x && g x
(||.) f g x = f x || g x

filter :: (a -> Bool) -> RDD a -> RDD a
filter f (FilteredRDD g rdd) = FilteredRDD (f &&. g) rdd
filter f rdd = FilteredRDD f rdd
