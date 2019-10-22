{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE LambdaCase #-}

module StatefulRating where

import           UIO

import           Data.Aeson.QQ                  ( aesonQQ )

import           Data.Dynamic

default (Text, Int)


showStatefulRatingPage :: Text -> UIO ()
showStatefulRatingPage target = do
    -- log to front UI
    print "Showing stateful rating page from Haskell code ..."

    -- log to backend
    logInfo $ display $ "Showing stateful rating page in window " <> target

    -- do the trick
    uiComm [aesonQQ|{
"type": "call"
, "name": "openWindow"
, "args": ["stateful-rating.html", #{target}]
}|]


-- stateful rank changing functions, reacting to UI button clicks

increaseStatefulRating :: UIO ()
increaseStatefulRating = do
    uio                    <- ask
    (currentRank, newRank) <-
        liftIO $ modifyMVar (haduiAppData uio) $ \mbRank -> do
            let (currentRank' :: Int) = case mbRank of
                    Nothing  -> 0
                    Just dyn -> fromDyn dyn 0
                newRank' = currentRank' + 1
            return ((Just $ toDyn newRank'), (currentRank', newRank'))

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

decreaseStatefulRating :: UIO ()
decreaseStatefulRating = do
    uio                    <- ask
    (currentRank, newRank) <-
        liftIO $ modifyMVar (haduiAppData uio) $ \mbRank -> do
            let (currentRank' :: Int) = case mbRank of
                    Nothing  -> 0
                    Just dyn -> fromDyn dyn 0
                newRank' = currentRank' - 1
            return ((Just $ toDyn newRank'), (currentRank', newRank'))

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

