{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}

module PoC
    ( demoProcedure
    )
where


import           RIO
import           UIO

default (Text, Int)


demoProcedure :: UIO ()
demoProcedure = do
    uiClearLog -- clear frontend log box
    print "This log msg should appear on front UI."
    logInfo "This log msg should appear on backend."

