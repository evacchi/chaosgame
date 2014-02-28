module Vacchi.Fractals.Types where


------------------------------------------
-- config types (used in config.hs)
------------------------------------------

data Fractal = Fractal {
	fractal     :: [IFS], -- IFS list
	scaleFactor :: Float, -- scaling factor
	iterations	:: Int,   -- number of iterations
	offsetX		:: Float, -- horizontal offset on the canvas
	offsetY		:: Float  -- vertical offset on the canvas
}

data Params = Params {
	penSize :: Float,			-- size of the circles on the canvas
	palette :: (Float,Float),   -- color interval of the palette (subrange in [0,1])
	alpha   :: Float -> Float,  -- function from a hue value to an alpha value [0,1]
	saturation :: Float->Float, -- function from a hue value to a saturation value [0,1]
	lightness :: Float->Float,  -- function from a hue value to a lightness value [0,1]
	animated :: Bool            -- True for an animated visualization, False for static 
}



------------------------------------------
-- types used in actual computations
------------------------------------------

-- A variation is just a function R^2->R^2
type Variation = (Float,Float) -> (Float,Float)

-- IFS data type
--
-- it represents a IFS function as a pair of triples 
-- specifying the coefficients for x, y
-- the last float value is a probability
--
-- the IfsVar alternate datatype provides a Variation type, which is a function
data IFS = Ifs (Float,Float,Float) (Float,Float,Float) Float
			| IfsVar (Float,Float,Float) (Float,Float,Float) Float Variation

-- definition of an IFS function:
ifs_def :: (Float,Float) 		-- input point (x_0,y_0) 
		-> (Float,Float,Float) 	-- coefficients for the x coord
		-> (Float,Float,Float)  -- coefficients for the y coord
		-> (Float,Float)		-- result (x_1, y_1)
ifs_def (x,y) (a,b,c) (d,e,f) = (a*x + b*y + c,   d*x + e*y + f)

-- default implementation for non-variated IFS
ifs :: (Float,Float) -> IFS -> (Float,Float)
ifs point (Ifs param1 param2 _)  = 
	let result = ifs_def point param1 param2
		in (fst result, snd result)

-- implementation for variated IFS
ifs point (IfsVar param1 param2 _ variation_function)  =
	let result = variation_function (ifs_def point param1 param2)
		in (fst result, snd result)


