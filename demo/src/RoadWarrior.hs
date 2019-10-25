{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}

module RoadWarrior where

import           UIO

import           Prelude                        ( head
                                                , putStrLn
                                                )

default (Text,Int)


fearless :: [Int] -> UIO ()
fearless numbers = do
    print "I feel good!"

    print $ tshow (head numbers) <> " is my lucky number!"


fearlessIO :: [Int] -> IO ()
fearlessIO numbers = do
    putStrLn "I feel good!"

    putStrLn $ show (head numbers) ++ " is my lucky number!"


dare :: IO ()
dare = do
    fearlessIO [3, 7, 21]
    fearlessIO []
