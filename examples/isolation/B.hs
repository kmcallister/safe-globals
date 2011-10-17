{-# LANGUAGE TemplateHaskell #-}
module B(go) where
import Data.Global
import Data.IORef

declareIORef "var" [t| Int |] [e| 5 |]

go :: IO ()
go = do
    n <- readIORef var
    putStrLn ("B: " ++ show n)
    writeIORef var (n+1)
