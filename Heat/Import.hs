{-# LANGUAGE BangPatterns #-}
module Heat.Import where

-- not yet R or D
type RDD = []

textFile :: String -> IO (RDD String)
textFile filename = do
  !text <- readFile filename
  return $ lines text
