module Vacchi.Fractals.Variations where

import Vacchi.Fractals.Types

---------------------------------------------------------------------------------------------------------
-- variations
linear (x,y) = (x,y)
symmetrical (x,y) = (-x,-y)
sinusoidal (x,y) = (sin x, sin y)
spherical (x,y) = let r2 = radius2(x,y) in (x/r2, y/r2)
swirl(x,y) = let r2 = radius2(x,y) in (x * sin r2 - y*cos r2, x*cos r2 +y*sin r2)
horseshoe(x,y) = let rr = (1/(sqrt (radius2(x,y)))) in (rr*(x-y)*(x+y), rr*2*x*y)

-- utility
radius2 (x,y) = x^2+y^2

---------------------------------------------------------------------------------------------------------

variation (x,y) affine_function variation_function =
	variation_function (ifs (x,y) affine_function)