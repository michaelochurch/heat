import Heat.Import

main :: IO ()
main = do
  rdd <- textFile "resources/log.txt"
  putStrLn $ (show . length $ rdd) ++ " lines."
