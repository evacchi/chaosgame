module Main where

import Vacchi.Fractals.Types
import Vacchi.Fractals.Config
import Vacchi.Fractals.ChaosGame

import Graphics.Gloss
import Graphics.Gloss.Raster.Field
import System.Random
import Data.Colour.SRGB
import Data.Colour.RGBSpace.HSL hiding (saturation,lightness)

import Debug.Trace


main = 
	let windowDescr = (InWindow
			"IFS" 	 -- window title
		(800, 800) 	 -- window size
		(10, 10)) 	 -- window position
		in
			if (animated params) then
				--display
				animate 
					windowDescr
					black			 -- background color
					myAnimation
			else
				display 
					windowDescr
					black			 -- background color
					$ picture (fractal configuration) 



-- draws a colored point on the cartesian plane
draw (x, y, c) =
	Translate (x+(offsetX configuration)) (y+(offsetY configuration))
	$ Color (colorFromHue c) 
	$ circle ((penSize params)/(scaleFactor configuration))

-- chooses a color in [0,1] from the given parameters
colorFromHue hue =
	let thePalette = (palette params)
	    rgb = hsl (fst thePalette + (hue*(snd thePalette - (fst thePalette)))) (saturation params hue) (lightness params hue)
		in makeColor (channelRed rgb) (channelGreen rgb) (channelBlue rgb) (alpha params hue)

-- generates a chaos source with a seed
chaosSource = take (iterations configuration) (randoms  (mkStdGen 21212) :: [Float])

-- draws a subset of the points for the given time span
-- 
-- impl. detail: the library invokes a function with a float representing the number
-- of seconds since the startup. We calculate round (secondsFloat * 10000) 
-- and plot that number of points, so we can give the illusion of an animation 
myAnimation seconds =
	pictureFrame (fractal configuration) (round$1+10000* seconds)


-- draws a subset of the points 
-- 
-- draws only the first N points
pictureFrame systemName nPoints = 
	let fact = (scaleFactor configuration) in
	Scale (scaleFactor configuration) (scaleFactor configuration)
		$ Pictures 
		$ map draw 
		$ take nPoints (chaosGame systemName (0,0,0) chaosSource)

-- draws all the "randomly" generated points 
picture systemName = 
	let fact = (scaleFactor configuration) in
	Scale (scaleFactor configuration) (scaleFactor configuration)
		$ Pictures 
		$ map draw 
		$ chaosGame systemName (0,0,0) chaosSource








