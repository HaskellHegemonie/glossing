{-# LANGUAGE RecordWildCards #-}

module Main where

import Data.Function
import Graphics.Gloss

{- Own -}
import Vig (decryptVig)

displayMode :: Display
displayMode = InWindow "testing" (300, 300) (0, 0)

disk :: Float -> Picture
disk r = ThickCircle (r / 2) r

curvDisk = disk 10

rate = 40

data SimulateState = SimulateState
  { sinY :: Float,
    sinPath :: [Point],
    cosY :: Float,
    cosPath :: [Point],
    x :: Float
  }
  deriving (Eq, Show)

drawPic :: SimulateState -> Picture
drawPic (SimulateState {..}) =
  Pictures
    [ curvDisk & Color red & Translate x sinY,
      Line sinPath & Color red,
      curvDisk & Color green & Translate x cosY,
      Line cosPath & Color green,
      Text "Cosine" & Color green & Translate (-400) (-100),
      Text "Sine" & Color red & Translate (-400) (-250),
      Text (decryptVig "puretosender" "Nwyaxwf tlxyjv.gha/nvxruyc") & Color (makeColor 0.95 0.15 0.56 0.8) & Translate (-400) (-1000)
    ]

initState = SimulateState 0 [] 0 [] 0

timeToState _ t (SimulateState {..}) = SimulateState {x = x', sinY = sinY', cosY = cosY', sinPath = (x', sinY) : sinPath, cosPath = (x', cosY) : cosPath}
  where
    x' = x + t * 40
    -- sinY = sin x' * 40
    sinY' = 100 * sin (x' * 2 * pi / 100)
    cosY' = 100 * cos (x' * 2 * pi / 100)

main :: IO ()
main = simulate displayMode white rate initState drawPic timeToState
