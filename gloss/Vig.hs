module Vig where
import Data.Char
import Data.Function


encryptVig :: String -> String -> String
encryptVig key plain = map (uncurry encryptChar) $ zip (map toLower key & cycle) plain
        where
          encryptChar :: Char -> Char -> Char
          encryptChar k p
                | all isAlpha [k, p] = ip + ik & (`mod` 26) & (+ bigBoy) & toEnum
                | otherwise = p
                        where
                          bigBoy = if isUpper p then bigA else smolA
                          bigA = fromEnum 'A'
                          smolA = fromEnum 'a'
                          ip = fromEnum p - bigBoy
                          ik = fromEnum k - bigBoy
                          
                          
                
decryptVig :: String -> String -> String
decryptVig key cipher = map (uncurry decryptChar) $ zip (map toLower key & cycle) cipher
        where
          decryptChar :: Char -> Char -> Char
          decryptChar k c
                | all isAlpha [k, c] = ic - ik + 26 & (`mod` 26) & (+ bigBoy) & toEnum
                | otherwise = c
                        where
                          bigBoy = if isUpper c then bigA else smolA
                          bigA = fromEnum 'A'
                          smolA = fromEnum 'a'
                          ic = fromEnum c - bigBoy
                          ik = fromEnum k - bigBoy
