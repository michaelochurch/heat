import Heat.Import
import Heat.RDD

main :: IO ()
main = do
  rdd        <- textFile "resources/log.txt"
  let isError str = (take 5 str) == "ERROR"
      errorlines =  rFilter isError rdd
  putStrLn $ (show . rCount $ errorlines) ++ " error lines."
