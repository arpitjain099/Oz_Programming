module Dft ( dft, findEdge, exploreNewVertex, showPath ) where

import Graph
import Stack
import Vertex

dft :: [Old_Edge] -> [Int]
dft [] = []
dft g  = showPath (findEdge (fst1(head g)) g (push (fst1(head g)) newStack) (push (fst1(head g)) newStack))

findEdge :: Node -> [Old_Edge] -> Stack Node -> Stack Node -> Stack Node
findEdge v1 g s cq
			| isEmpty s			= cq 
			| isEdgeExist v1 g (showPath s)	= exploreNewVertex (getEdge v1 g (showPath s)) g s cq
			| otherwise			= findEdge (top (pop s)) g (pop s) cq

exploreNewVertex :: Old_Edge -> [Old_Edge] -> Stack Node -> Stack Node -> Stack Node
exploreNewVertex e g s cq
			| not (isEdgeExist (snd1 e) g (showPath s)) = findEdge (fst1 e) (visitGraph e g) (push (snd1 e) s) (push (snd1 e) cq)
			| otherwise				    = findEdge (snd1 e) (visitGraph e g) (push (fst1 e) s) (push (snd1 e) cq)

showPath :: Stack Node -> [Int]
showPath s = [get x | x <- (printData s)]


