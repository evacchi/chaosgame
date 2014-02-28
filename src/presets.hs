module Vacchi.Fractals.Presets where
import Vacchi.Fractals.Types
import Vacchi.Fractals.Variations


------------------------------------------------------------------------------------

sierpinski =  Fractal {
	fractal = 
		[ Ifs (0.5, 0.0, 0) 	(0.0, 0.5, 0.0) (1/3)
		, Ifs (0.5, 0.0, 0.25)	(0.0, 0.5, 0.5) (1/3) 
		, Ifs (0.5,0,0.5) 		(0, 0.5, 0.0) 	(1/3) ] ,
	scaleFactor = 700,
	iterations = 100000,
	offsetX = -0.5,
	offsetY = -0.5
}


sierpinski_variated =  Fractal {
	fractal = 
		[ IfsVar (0.5, 0.0, 0) 		(0.0, 0.5, 0.0) (1/3) swirl
		, IfsVar (0.5, 0.0, 0.25)	(0.0, 0.5, 0.5) (1/3) linear
		, IfsVar (0.5,0,0.5) 		(0, 0.5, 0.0) 	(1/3) horseshoe] ,
	scaleFactor = 600,
	iterations = 100000,
	offsetX = -0.3,
	offsetY = -0.4
}
barnsley = Fractal {
	fractal = 
		[Ifs (0,0,0) 		(0,0.16,0)			0.01	-- 1%
		,Ifs (0.85,0.04,0)	(-0.04,0.85,1.6) 	0.85	-- 85%
		,Ifs (0.2,-0.26,0)	(0.23,0.22,1.6) 	0.07	-- 7%
		,Ifs (-0.15,0.28,0)	(0.26,0.24,0.44)	0.07],	-- 7%
	scaleFactor = 70,
	iterations = 100000,
	offsetX = 0,
	offsetY = -5
}

barnsley_variated = Fractal {
	fractal = 
		[IfsVar (0,0,0) 		(0,0.16,0)			0.01	linear -- 1%
		,IfsVar (0.85,0.04,0)	(-0.04,0.85,1.6) 	0.85	linear -- 85%
		,IfsVar (0.2,-0.26,0)	(0.23,0.22,1.6) 	0.07	(horseshoe) -- 7%
		,IfsVar (-0.15,0.28,0)	(0.26,0.24,0.44)	0.07	(horseshoe) ],-- 7%
	scaleFactor = 50,
	iterations = 100000,
	offsetX = 0,
	offsetY = -3
}


heighway = 
	let s = (1/(sqrt 2))
		in Fractal {
			fractal = 
				[Ifs 	(s*(cos (pi/4)),s*(-sin(pi/4)),0) 
						(s*(sin (pi/4)),s*(cos(pi/4)),0)			0.5
				,Ifs    (s*(cos (3*pi/4)),s*(-sin(3*pi/4)),1) 
						(s*(sin (3*pi/4)),s*(cos(3*pi/4)),0)		0.5 ],-- 7%
			scaleFactor = 500,
			iterations = 300000,
			offsetX = -0.4,
			offsetY = -0.2
		}


heighway_variated = 
	let s = (1/(sqrt 2))
		in Fractal {
			fractal = 
				[IfsVar 	(s*(cos (pi/4)),s*(-sin(pi/4)),0) 
						(s*(sin (pi/4)),s*(cos(pi/4)),0)			0.5 	(spherical . swirl)
				,IfsVar    (s*(cos (3*pi/4)),s*(-sin(3*pi/4)),1) 
						(s*(sin (3*pi/4)),s*(cos(3*pi/4)),0)		0.5 	(symmetrical)],
			scaleFactor = 200,
			iterations = 200000,
			offsetX = 0,
			offsetY = -0.2
		}


------------------------------------------------------------------------------------