module Vacchi.Fractals.ChaosGame where

import Vacchi.Fractals.Types

import Data.Colour.SRGB
import Data.Colour.RGBSpace.HSL hiding (saturation,lightness)


-- Calculates a set of points on the plain for the input IFS
-- starting from the given input point
-- and using a list of floats as a source of randomness

chaosGame :: [IFS] -- a list of IFS functions
		  -> (Float,Float,Float)   -- an input triple, where (x,y) is on the cartesian plane, 
		  						   -- and c in [0,1] is a color
		  -> [Float]               -- a list of pseudo-random floats in the [0,1] interval 
		  -> [(Float,Float,Float)] -- a list of (x,y,c) triples
chaosGame inputFractal (x,y,c) (z:zs) =
	let result = (generate inputFractal (x,y,c) z)
		in result:(chaosGame inputFractal result zs)
chaosGame _ _ [] = []




-- applies a function from the list to the input triple and return
-- the function chooses a function 0<=k<=(length inputFractal) 
-- with k such that  p_k <= floatVal < p_{k+1}
generate :: [IFS] -- a list of IFS functions
         -> (Float,Float,Float)  -- the input triple (x,y) in R, c in [0,1]
         -> Float 				 -- a pseudo-random float value in [0,1]
         -> (Float,Float,Float)  -- the resulting triple
generate inputFractal (x,y,c) floatVal =
	let index = (chooseFunction inputFractal floatVal)  
	    result= ifs (x,y) ( inputFractal !! index )
	    	in ( (fst result), (snd result), (0.5*(c+(getColorFromIndex inputFractal index))) )

-- get a color value (a float in [0,1]) from the index of a function in the IFS
getColorFromIndex :: [IFS] -> Int -> Float
getColorFromIndex functionSystemList index =
	(fromIntegral index) / (fromIntegral ((length functionSystemList) -1)) 

-- choose function f with probability p
chooseFunction xs floatVal =
	function_choice' xs floatVal 0.0 0

-- choose a function among the given list with probability p
-- floatVal is considered as a random variabile in range [-1,1]
-- so we partition the range accordingly
function_choice' ((x@(Ifs _ _ p)):xs) floatVal float n =
	if floatVal < p+float then n else function_choice' xs floatVal (p+float) (n+1)
function_choice' ((x@(IfsVar _ _ p _)):xs) floatVal float n =
	if floatVal < p+float then n else function_choice' xs floatVal (p+float) (n+1)

function_choice' [] _ _ n = n-1


