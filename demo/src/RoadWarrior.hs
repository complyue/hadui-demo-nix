{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}

module RoadWarrior where

import           UIO

default (Text,Int)

fearless :: UIO ()
fearless = do
    print "I feel good!"
