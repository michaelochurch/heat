import qualified Heat.Import as Import
import qualified Heat.RDD    as RDD

main :: IO ()
main = do
  rdd        <- Import.textFile "resources/log.txt"
  let isError str = (take 5 str) == "ERROR"
      errorlines =  RDD.filter isError rdd
  putStrLn $ (show . RDD.count $ errorlines) ++ " error lines."
