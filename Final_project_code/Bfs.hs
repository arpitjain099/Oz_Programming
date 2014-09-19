module Bfs ( bfs, findEdge, exploreNewVertex, showPath ) where

import Graph
import Queue
import Vertex

bfs :: [Old_Edge] -> Int -> [Int]
bfs [] _ = []
bfs g goal
	| get (fst1(head g)) == goal	= [goal]
	| otherwise			= reverse (showPath (findEdge goal (fst1(head g)) g (add (fst1(head g)) newQueue) 
													(add (fst1(head g)) newQueue)))

findEdge :: Int -> Node -> [Old_Edge] -> Queue Node -> Queue Node -> Queue Node
findEdge goal v1 g oq cq
	| isEmpty oq			 = newQueue	
	| isEdgeExist v1 g (showPath cq) = exploreNewVertex goal (getEdge v1 g (showPath cq)) g oq cq
	| otherwise			 = findEdge goal (top (snd(remove oq))) g (snd(remove oq)) cq

exploreNewVertex :: Int -> Old_Edge -> [Old_Edge] -> Queue Node -> Queue Node -> Queue Node
exploreNewVertex goal e g oq cq
	| goal == (get(snd1 e))	= add (snd1 e) cq
	| otherwise		= findEdge goal (top oq) (visitGraph e g) (add (snd1 e) oq) (add (snd1 e) cq)


showPath :: Queue Node -> [Int]
showPath oq = [get x | x <- (printData oq)]

