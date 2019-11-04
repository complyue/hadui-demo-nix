{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE QuasiQuotes #-}

module Rating where

import           UIO

import           Data.Aeson.QQ                  ( aesonQQ )

default (Text, Int)


showRatingPage :: Text -> UIO ()
showRatingPage windowName = do
    -- log to front UI
    print "Showing rating page from Haskell code ..."

    -- log to backend
    logInfo $ display $ "Showing rating page in window " <> windowName

    -- do the trick
    uiComm [aesonQQ|{
"type": "call"
, "name": "openWindow"
, "args": ["rating.html", #{windowName}]
}|]


-- stateless rank changing functions, reacting to UI button clicks

increaseRating :: Int -> UIO ()
increaseRating currentRank = do
    let newRank = currentRank + 1
    logInfo
        $  display
        $  "Increase rating from "
        <> tshow currentRank
        <> " to "
        <> tshow newRank
    uiComm [aesonQQ|{
"type": "call"
, "name": "updateRank"
, "args": #{newRank}
}|]

decreaseRating :: Int -> UIO ()
decreaseRating currentRank = do
    let newRank = currentRank - 1
    logInfo
        $  display
        $  "Decrease rating from "
        <> tshow currentRank
        <> " to "
        <> tshow newRank
    uiComm [aesonQQ|{
"type": "call"
, "name": "updateRank"
, "args": #{newRank}
}|]


