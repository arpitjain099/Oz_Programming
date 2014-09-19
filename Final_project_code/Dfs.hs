module Dfs ( dfs, findEdge, exploreNewVertex, isGoalFoundWithNoEdges, showPath ) where

import Graph
import Stack
import Vertex

dfs :: [Old_Edge] -> Int -> [Int]
dfs [] _ = []
dfs g goal
	| get (fst1(head g)) == goal = [goal]
	| otherwise		     = showPath (findEdge goal (snd1(head g)) (visitGraph (head g) g) (push (fst1(head g)) newStack))

findEdge :: Int -> Node -> [Old_Edge] -> Stack Node -> Stack Node
findEdge goal v1 g s
	| isEmpty s			= newStack 
	| isEdgeExist v1 g (showPath s)	= exploreNewVertex goal (getEdge v1 g (showPath s)) g s
	| otherwise			= findEdge goal (top (pop s)) g (pop s)

exploreNewVertex :: Int -> Old_Edge -> [Old_Edge] -> Stack Node -> Stack Node
exploreNewVertex goal e g s
	| goal == (get(fst1 e))			    = push (fst1 e) s
	| isGoalFoundWithNoEdges goal e g s	    = push (snd1 e) (push (fst1 e) s)
	| not (isEdgeExist (snd1 e) g (showPath s)) = findEdge goal (fst1 e) (visitGraph e g) (push (snd1 e) s)
	| otherwise				    = findEdge goal (snd1 e) (visitGraph e g) (push (fst1 e) s)

isGoalFoundWithNoEdges :: Int -> Old_Edge -> [Old_Edge] -> Stack Node -> Bool
isGoalFoundWithNoEdges goal e g s
	| (goal == (get(snd1 e))) && not (isEdgeExist (snd1 e) g (showPath s))	= True
	| otherwise								= False

showPath :: Stack Node -> [Int]
showPath s = [get x | x <- (printData s)]

