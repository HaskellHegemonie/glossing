module Main where
import Vis
import Linear
import SpatialMath

type R = Double

blueCube :: VisObject R
blueCube = Cube 1 Solid blue

axes = VisObjects
        [ Line Nothing [V3 0 0 0, V3 1 0 0] red
        , Line Nothing [V3 0 0 0, V3 0 1 0] green
        , Line Nothing [V3 0 0 0, V3 0 0 1] blue ]

orient :: VisObject Double -> VisObject R
orient pict = RotEulerDeg (Euler 270 180 0) $ pict
main :: IO ()
main = display defaultOpts (orient axes)
