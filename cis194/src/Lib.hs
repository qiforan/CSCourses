module Lib
    ( someFunc
    ) where

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n-1)

someFunc :: IO ()
someFunc = print(factorial 100)
