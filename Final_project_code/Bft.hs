module Bft ( bft, findEdge, exploreNewVertex,	showPath ) where

import Graph
import Queue
import Vertex

bft :: [Old_Edge] -> [Int]
bft [] = []
bft g  = reverse (showPath (findEdge (fst1(head g)) g (add (fst1(head g)) newQueue) (add (fst1(head g)) newQueue)))

findEdge :: Node -> [Old_Edge] -> Queue Node -> Queue Node -> Queue Node
findEdge v1 g oq cq
	| isEmpty oq 			 = cq
	| isEdgeExist v1 g (showPath cq) = exploreNewVertex (getEdge v1 g (showPath cq)) g oq cq
	| otherwise		         = findEdge (top (snd(remove oq))) g (snd(remove oq)) cq

exploreNewVertex :: Old_Edge -> [Old_Edge] -> Queue Node -> Queue Node -> Queue Node
exploreNewVertex e g oq cq = findEdge (top oq) (visitGraph e g) (add (snd1 e) oq) (add (snd1 e) cq)


showPath :: Queue Node -> [Int]
showPath oq = [get x | x <- (printData oq)]

