{-# LANGUAGE BangPatterns #-}
module Heat.Import where

import Heat.RDD

textFile :: String -> IO (RDD String)
textFile filename = do
  !text <- readFile filename
  return $ (FromFile filename)$ lines text
