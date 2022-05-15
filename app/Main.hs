module Main where

import qualified HelloLib (someFunc)

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  HelloLib.someFunc
