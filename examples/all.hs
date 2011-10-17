{-# LANGUAGE TemplateHaskell #-}
import Data.Global
import Data.IORef
import Control.Concurrent
import Control.Concurrent.STM

declareIORef      "ioRef"  [t| Char |] [e| 'x' |]
declareMVar       "mVar"   [t| Char |] [e| 'x' |]
declareEmptyMVar  "emVar"  [t| Char |]
declareSampleVar  "sVar"   [t| Char |] [e| 'x' |]
declareChan       "chan"   [t| Char |]
declareQSem       "qSem"               [e| 3   |]
declareQSemN      "qSemN"              [e| 3   |]
declareTVar       "tVar"   [t| Char |] [e| 'x' |]
declareTMVar      "tMVar"  [t| Char |] [e| 'x' |]
declareEmptyTMVar "etMVar" [t| Char |]
declareTChan      "tChan"  [t| Char |]

main :: IO ()
main = do
    readIORef     ioRef >>= print
    readMVar      mVar  >>= print
    readSampleVar sVar  >>= print

    putMVar   emVar 'y'
    readMVar  emVar >>= print

    writeChan chan  'y'
    readChan  chan  >>= print

    waitQSem  qSem
    waitQSemN qSemN 2

    (>>= print) . atomically $ do
        a <- readTVar  tVar
        b <- readTMVar tMVar

        putTMVar etMVar 'y'
        c <- readTMVar etMVar

        writeTChan tChan 'y'
        d <- readTChan tChan

        return (a,b,c,d)
