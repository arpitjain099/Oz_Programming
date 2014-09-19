module Vertex ( Vertex, newVertex, visit, isVisited, get ) where

newtype Vertex a = MyVertex (a, Bool) 
		   deriving(Eq, Show, Read)

visit :: Vertex (a, Bool) -> Vertex (a, Bool)
visit (MyVertex (x, _))		= MyVertex (x, True)

isVisited :: Vertex (a, Bool) -> Bool
isVisited (MyVertex (x, y))
	| y == True				= True
	| otherwise				= False

get :: Vertex (a, Bool) -> a
get (MyVertex pair)			= fst (fst pair)

newVertex :: a -> Vertex (a, Bool)
newVertex x = MyVertex ((x, False), False)
