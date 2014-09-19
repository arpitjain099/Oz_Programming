module Kruskals (kruskals, exploreShortestEdge, isNotInMst, rule) where

import Graph
import Priority_queue
import Vertex
import Prims (filterEdges, isNotDuplicate, formsCycle)

kruskals 	:: [Old_Edge] -> [(Int,Int,Int)]
kruskals []	= []
kruskals g	= printGraph(printData(exploreShortestEdge (snd(remove(addAll rule g newPQueue))) (add rule (head (rule g)) newPQueue)))

exploreShortestEdge:: PQueue Old_Edge -> PQueue Old_Edge -> PQueue Old_Edge
exploreShortestEdge oq cq
	| isEmpty oq				= cq
	| isNotInMst (top oq) (printData cq) &&
		not (formsCycle (top oq) (makeUnDirected (printData cq))) 	= exploreShortestEdge 
											(snd (remove oq)) (add rule (top oq) cq)
	| otherwise 				= exploreShortestEdge (snd (remove oq)) cq

isNotInMst :: Old_Edge -> [Old_Edge] -> Bool
isNotInMst e cs
	| length (filterEdges isNotDuplicate e cs)/= length cs	= False
	| otherwise	= True

rule	:: [Old_Edge] -> [Old_Edge]
rule g	= quickSortW g
