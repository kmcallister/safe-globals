{-# LANGUAGE TemplateHaskell #-}
module A(go) where
import Data.Global
import Data.IORef

declareIORef "var" [t| Int |] [e| 0 |]

go :: IO ()
go = do
    n <- readIORef var
    putStrLn ("A: " ++ show n)
    writeIORef var (n+1)
