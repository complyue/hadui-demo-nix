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
showStatefulRatingPage windowName = do
    -- log to front UI
    print "Showing stateful rating page from Haskell code ..."

    -- log to backend
    logInfo $ display $ "Showing stateful rating page in window " <> windowName

    -- do the trick
    uiComm [aesonQQ|{
"type": "call"
, "name": "openWindow"
, "args": ["stateful-rating.html", #{windowName}]
}|]


-- stateful rank showing/changing functions, initialize UI display and
-- reacting to UI button clicks

showCurrentRating :: UIO ()
showCurrentRating = do
    uio    <- ask
    mbRank <- liftIO $ readMVar (haduiAppData uio)
    let (currentRank :: Int) = case mbRank of
            Nothing  -> 0
            Just dyn -> fromDyn dyn 0
    uiComm [aesonQQ|{
"type": "call"
, "name": "updateRank"
, "args": #{currentRank}
}|]

increaseStatefulRating :: UIO ()
increaseStatefulRating = do
    uio <- ask
    liftIO $ modifyMVar_ (haduiAppData uio) $ \mbRank -> do
        let (currentRank :: Int) = case mbRank of
                Nothing  -> 0
                Just dyn -> fromDyn dyn 0
            newRank = currentRank + 1
        runUIO uio $ do
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
        return $ Just $ toDyn newRank

decreaseStatefulRating :: UIO ()
decreaseStatefulRating = do
    uio <- ask
    liftIO $ modifyMVar_ (haduiAppData uio) $ \mbRank -> do
        let (currentRank :: Int) = case mbRank of
                Nothing  -> 0
                Just dyn -> fromDyn dyn 0
            newRank = currentRank - 1
        runUIO uio $ do
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
        return $ Just $ toDyn newRank

