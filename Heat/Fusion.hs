module Heat.Fusion where

fuseMapFilter :: (a -> b) -> (a -> Bool) -> a -> [b]
fuseMapFilter mapFn filterFn =
  \a -> if filterFn a then [mapFn a] else []

fuseFilterMap :: (b -> Bool) -> (a -> b) -> a -> [b]
fuseFilterMap filterFn mapFn =
  \a -> let b = mapFn a in if filterFn b then [b] else []

-- TODO: replace this with something more principled, e.g. QuickCheck
-- Laws such as fuseFilterMap (const True)  f == (:[]) . f
--              fuseFilterMap (const False) f == const []

fuseCheck :: IO ()
fuseCheck = do
  let xs = [1, 2, 7, 8, 13]
      g x = x * x + 1
      f1 = fuseFilterMap even g
      f2 = fuseMapFilter g even
      check x y = if x == y then return () else error "check failed"
  check (concatMap f1 xs) [2, 50, 170]
  check (concatMap f2 xs) [5, 65]
