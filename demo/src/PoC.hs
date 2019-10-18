{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module PoC
    ( demoProcedure
    )
where

import           RIO

import           UIO


demoProcedure :: UIO ()
demoProcedure = do
    uiLog "This log msg should appear on front UI."
    logInfo "This log msg should appear on backend."


