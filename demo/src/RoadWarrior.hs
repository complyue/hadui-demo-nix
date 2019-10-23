{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}

module RoadWarrior where

import           UIO

import           Prelude                        ( head )

default (Text,Int)

fearless :: [Int] -> UIO ()
fearless numbers = do
    print "I feel good!"

    print $ tshow (head numbers) <> " is my lucky number!"
