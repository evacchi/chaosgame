module Vacchi.Fractals.Config where

import Vacchi.Fractals.Types
import Vacchi.Fractals.Presets
import Vacchi.Fractals.Variations



configuration = 
	sierpinski
	-- sierpinski_variated
	-- barnsley
	-- barnsley_variated
	-- heighway
	-- heighway_variated

params = Params {
	animated   = False,
	penSize = 1.02,
	palette = (0,60),
	alpha      = \hue -> hue*0.3,
	saturation = \hue -> 0.7,
	lightness  = \hue -> 0.5
}