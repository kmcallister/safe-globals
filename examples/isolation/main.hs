import qualified A
import qualified B

import Control.Monad

main :: IO ()
main = replicateM_ 5 (A.go >> B.go)
