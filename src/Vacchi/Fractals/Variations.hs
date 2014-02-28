module Vacchi.Fractals.Variations where

import Vacchi.Fractals.Types

---------------------------------------------------------------------------------------------------------
-- variations
linear :: (t, t) -> (t, t)
linear (x,y) = (x,y)

symmetrical :: Num t => (t, t) -> (t, t)
symmetrical (x,y) = (-x,-y)

sinusoidal :: Floating t => (t, t) -> (t, t)
sinusoidal (x,y) = (sin x, sin y)

spherical :: Floating a => (a, a) -> (a, a)
spherical (x,y) = let r2 = radius2(x,y) in (x/r2, y/r2)

swirl :: Floating t => (t, t) -> (t, t)
swirl(x,y) = let r2 = radius2(x,y) in (x * sin r2 - y*cos r2, x*cos r2 +y*sin r2)

horseshoe :: Floating t => (t,t) -> (t,t)
horseshoe(x,y) = let rr = (1/(sqrt (radius2(x,y)))) in (rr*(x-y)*(x+y), rr*2*x*y)

-- utility
radius2 :: Num t => (t,t) -> t
radius2 (x,y) = x*x+y*y

---------------------------------------------------------------------------------------------------------

variation :: (Float, Float) -> IFS -> ((Float, Float) -> t) -> t
variation (x,y) affine_function variation_function =
	variation_function (ifs (x,y) affine_function)