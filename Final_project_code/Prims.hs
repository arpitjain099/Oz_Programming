module Prims ( prims, exploreShortestEdge, getEligEdge, findEdges, formsCycle, searchForCycle, mapGraph, generateListOfGraphs, explorerNewEdges, removeDuplicateEdges, mapCycles, filterEdges, isNotDuplicate, rule) where

import Graph
import Priority_queue
import Vertex
import Bft

prims 		:: [Old_Edge] -> [(Int,Int,Int)]
prims []	= []
prims g		= printGraph(printData (exploreShortestEdge (visitGraph (head (rule g)) g) (add rule (head (rule g)) newPQueue)))

exploreShortestEdge		:: [Old_Edge] -> PQueue Old_Edge -> PQueue Old_Edge
exploreShortestEdge g cq
	| isEmpty cq		= newPQueue
	| ((vertexCount (printData cq)) /= (vertexCount g))	= exploreShortestEdge g (getEligEdge g cq)
	| otherwise		= cq

getEligEdge	:: [Old_Edge] -> PQueue Old_Edge -> PQueue Old_Edge
getEligEdge g cq= add rule (top(addAll rule (removeCyclicEdges g cq) newPQueue)) cq

removeCyclicEdges	:: [Old_Edge] -> PQueue Old_Edge -> [Old_Edge]
removeCyclicEdges g cq	= mapCycles formsCycle (printData cq) (findEdges g (printData cq) cq)

mapCycles	:: (Old_Edge -> [Old_Edge] -> Bool) -> [Old_Edge] -> [Old_Edge] -> [Old_Edge]
mapCycles f mst []	= []
mapCycles f mst (x:xs)
	| not(f x mst)	= [x] ++ (mapCycles f mst xs)
	| otherwise	= (mapCycles f mst xs)

findEdges		:: [Old_Edge] -> [Old_Edge] -> PQueue Old_Edge -> [Old_Edge]
findEdges g [] cq	= []
findEdges g (x:xs) cq	= (explorerNewEdges cq x g) ++ (findEdges g xs cq)

formsCycle		:: Old_Edge -> [Old_Edge] -> Bool
formsCycle (v1,w,v2) []	= False
formsCycle (v1,w,v2) es	= isCycle (searchForCycle (v1,w,v2) es) (v1,w,v2)
				where
					isCycle	:: [[Int]] -> Old_Edge -> Bool
					isCycle [] _	= False
					isCycle (l:ls) (v1,w,v2)
						| elem (get v1) l && elem (get v2) l	= True
						| otherwise	= isCycle ls (v1,w,v2)

searchForCycle	:: Old_Edge -> [Old_Edge] -> [[Int]]
searchForCycle (v1,w,v2) []	= []
searchForCycle (v1,w,v2) es	= mapGraph bft (generateListOfGraphs (last es) es)

mapGraph	:: ([Old_Edge] -> [Int]) -> [[Old_Edge]] -> [[Int]]
mapGraph f []	= []
mapGraph f (g:gs)= [f g] ++ (mapGraph f gs)

generateListOfGraphs	:: Old_Edge -> [Old_Edge] -> [[Old_Edge]]
generateListOfGraphs e es
	| e /= es!!0	= [es] ++ (generateListOfGraphs e ((tail es) ++ [head es]))
	| otherwise	= [es]

explorerNewEdges	:: PQueue Old_Edge -> Old_Edge -> [Old_Edge] -> [Old_Edge]
explorerNewEdges cq (v1,w,v2) g	= removeDuplicateEdges (printData cq) ((getAllEdges v1 g []) ++ (getAllEdges v2 g []))

removeDuplicateEdges	:: [Old_Edge] -> [Old_Edge] -> [Old_Edge]
removeDuplicateEdges (q:qs) es
	| (length qs) /= 0	= removeDuplicateEdges qs (filterEdges isNotDuplicate q es)
	| (length qs) == 0	= (filterEdges isNotDuplicate q es)

filterEdges 		:: (Old_Edge -> Old_Edge -> Bool) -> Old_Edge -> [Old_Edge] -> [Old_Edge]
filterEdges f q es	= [x | x <- es, f q x]

isNotDuplicate	:: Old_Edge -> Old_Edge -> Bool
isNotDuplicate (a,b,c) (x,y,z)
	| a == z && c == x	= False
	| a == x && c == z	= False
	| otherwise		= True

rule	:: [Old_Edge] -> [Old_Edge]
rule g	= quickSortW g
