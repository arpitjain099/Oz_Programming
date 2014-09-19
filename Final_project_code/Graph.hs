module Graph ( Node, Weight, Old_Edge, isEdgeExist, getEdge, getAllEdges, visitGraph, makeEdgeVisited, isExistInList, makeUnDirected,	quickSort, quickSortW, edgeCount, vertexCount, printGraph, fst1, mdl1, snd1, buildGraph, convertGraphToVertex, petersenGraph1, petersenGraph2, tree1, tree2, graph1, graph2, graph3, graph4 ) where

import Vertex
import Data.List (nub, unzip3)

type Node	= Vertex (Int, Bool)
type Weight	= Int
type Old_Edge 	= (Node, Weight, Node)


isEdgeExist :: Node -> [Old_Edge] -> [Int] -> Bool
isEdgeExist v g xs
	| elem True [True | (v1, w, v2) <- g, 
						get v1 == get v && 
						isVisited v1 == False &&
						not (isExistInList (get v2) xs)]	= True
	| otherwise									= False

getEdge	:: Node -> [Old_Edge] -> [Int] -> Old_Edge
getEdge v g xs = head (getAllEdges v g xs)

getAllEdges :: Node -> [Old_Edge] -> [Int] -> [Old_Edge]
getAllEdges v g xs = quickSort [(v1, w, v2) | (v1, w, v2) <- g, 
						get v1 == get v && 
						isVisited v1 == False &&
						not (isExistInList (get v2) xs)]

visitGraph :: Old_Edge -> [Old_Edge] -> [Old_Edge]
visitGraph edge g = map evaluate g
			where
			evaluate :: Old_Edge -> Old_Edge
			evaluate e
				| edge == e		= makeEdgeVisited e
				| otherwise		= e
							
makeEdgeVisited	:: Old_Edge -> Old_Edge
makeEdgeVisited (v1, w, v2)	= (visit v1, w, v2)

isExistInList :: Int -> [Int] -> Bool
isExistInList _ [] = False 
isExistInList a xs = elem a xs

makeUnDirected :: [Old_Edge] -> [Old_Edge]
makeUnDirected g = quickSortW([e1 | e1 <- g] ++ [(z,y,x)| (x,y,z) <- g])

quickSort :: [Old_Edge] -> [Old_Edge]
quickSort [] = []
quickSort (x:xs) = quickSort [y | y <- xs, get(snd1 y) <= get(snd1 x)] 
				++ [x] 
				++ quickSort[y | y <- xs, get(snd1 y) > get(snd1 x)]

quickSortW :: [Old_Edge] -> [Old_Edge]
quickSortW [] = []
quickSortW (x:xs) = quickSortW [y | y <- xs, (mdl1 y) <= (mdl1 x)] 
				++ [x] 
				++ quickSortW[y | y <- xs, (mdl1 y) > (mdl1 x)]
														
edgeCount :: [Old_Edge] -> Int
edgeCount g = length g

vertexCount :: [Old_Edge] -> Int
vertexCount g = length (convertGraphToVertex g)

convertGraphToVertex :: [Old_Edge] -> [Int]
convertGraphToVertex g = (combine ( unzip3[(get x, w, get y) | (x,w,y) <- g]))
							where 
								combine	:: ([Int], [Int], [Int]) -> [Int]
								combine (xs,ws,ys) = nub ( concat[xs ++ ys] )

printGraph :: [Old_Edge] -> [(Int, Int, Int)]
printGraph g = [(get x, w, get y) | (x, w, y) <- g]

fst1 :: (a,b,c) -> a
fst1 (a,b,c) = a

mdl1 :: (a,b,c) -> b
mdl1 (a,b,c) = b

snd1 :: (a,b,c) -> c
snd1 (a,b,c) = c

buildGraph :: String -> [Old_Edge]
buildGraph s
	| s == "petersenGraph1"	= petersenGraph1
	| s == "petersenGraph2" = petersenGraph2
	| s == "tree1"		= tree1
	| s == "tree2"		= tree2
	| s == "graph1"		= graph1
	| s == "graph2"		= graph2
	| s == "graph3"		= graph3
	| s == "graph4"		= graph4
	| otherwise		= []
	
petersenGraph1		:: [Old_Edge]
petersenGraph1		= [(newVertex 0, 10, newVertex 1), (newVertex 1, 10, newVertex 0), (newVertex 1, 8, newVertex 2), 
					   (newVertex 2, 8, newVertex 1), (newVertex 2, 12, newVertex 3), (newVertex 3, 12, newVertex 2), 
					   (newVertex 3, 14, newVertex 4), (newVertex 4, 14, newVertex 3), (newVertex 4, 11, newVertex 0), 
					   (newVertex 0, 11, newVertex 4), (newVertex 5, 3, newVertex 6), (newVertex 6, 3, newVertex 5), 
					   (newVertex 6, 1, newVertex 7), (newVertex 7, 1, newVertex 6), (newVertex 7, 3, newVertex 8), 
					   (newVertex 8, 3, newVertex 7), (newVertex 8, 5, newVertex 9), (newVertex 9, 5, newVertex 8),
					   (newVertex 9, 8, newVertex 5), (newVertex 5, 8, newVertex 9), (newVertex 5, 17, newVertex 0), 
					   (newVertex 0, 17, newVertex 5), (newVertex 6, 9, newVertex 2), (newVertex 2, 9, newVertex 6), 
					   (newVertex 7, 8, newVertex 4), (newVertex 4, 8, newVertex 7), (newVertex 8, 3, newVertex 1), 
					   (newVertex 1, 3, newVertex 8), (newVertex 9, 1, newVertex 3), (newVertex 3, 1, newVertex 9)]

petersenGraph2		:: [Old_Edge]
petersenGraph2		= [(newVertex 0, 10, newVertex 1), (newVertex 1, 8, newVertex 2), 
					   (newVertex 2, 12, newVertex 3), 
					   (newVertex 3, 14, newVertex 4), (newVertex 4, 11, newVertex 0), 
					   (newVertex 5, 3, newVertex 6), 
					   (newVertex 6, 1, newVertex 7), (newVertex 7, 3, newVertex 8), 
					   (newVertex 8, 5, newVertex 9), 
					   (newVertex 9, 8, newVertex 5), (newVertex 5, 17, newVertex 0), 
					   (newVertex 6, 9, newVertex 2), 
					   (newVertex 7, 8, newVertex 4), (newVertex 8, 3, newVertex 1), 
					   (newVertex 9, 1, newVertex 3)]
					   

tree1				:: [Old_Edge]
tree1				= [(newVertex 1, 10, newVertex 2), (newVertex 2, 6, newVertex 5), (newVertex 5, 2, newVertex 6),
					   (newVertex 5, 2, newVertex 7), (newVertex 2, 5, newVertex 8), (newVertex 1, 4, newVertex 3),
					   (newVertex 3, 1, newVertex 9), (newVertex 3, 9, newVertex 10), (newVertex 1, 8, newVertex 4),
					   (newVertex 4, 4, newVertex 11), (newVertex 11, 12, newVertex 12), (newVertex 11, 1, newVertex 13)]
					   

tree2				:: [Old_Edge]
tree2				= [(newVertex 1, 10, newVertex 2), (newVertex 2, 10, newVertex 1), (newVertex 2, 6, newVertex 5), 
					   (newVertex 5, 6, newVertex 2), (newVertex 5, 2, newVertex 6), (newVertex 6, 2, newVertex 5), 
					   (newVertex 5, 2, newVertex 7), (newVertex 7, 2, newVertex 5), (newVertex 2, 5, newVertex 8), 
					   (newVertex 8, 5, newVertex 2), (newVertex 1, 4, newVertex 3), (newVertex 3, 4, newVertex 1), 
					   (newVertex 3, 1, newVertex 9), (newVertex 9, 1, newVertex 3), (newVertex 3, 9, newVertex 10), 
					   (newVertex 10, 9, newVertex 3), (newVertex 1, 8, newVertex 4), (newVertex 4, 8, newVertex 1), 
					   (newVertex 4, 4, newVertex 11), (newVertex 11, 4, newVertex 4), (newVertex 11, 12, newVertex 12), 
					   (newVertex 12, 12, newVertex 11), (newVertex 13, 1, newVertex 11), (newVertex 11, 1, newVertex 13)]


graph1				:: [Old_Edge]
graph1				= [(newVertex 0, 5, newVertex 1), (newVertex 1, 5, newVertex 0), (newVertex 1, 6, newVertex 2), 
					   (newVertex 2, 6, newVertex 1), (newVertex 0, 2, newVertex 9), (newVertex 9, 2, newVertex 0), 
					   (newVertex 1, 4, newVertex 3), (newVertex 3, 4, newVertex 1), (newVertex 3, 3, newVertex 9), 
					   (newVertex 9, 3, newVertex 3)]


graph2				:: [Old_Edge]
graph2				= [(newVertex 0, 5, newVertex 1), (newVertex 1, 6, newVertex 2), (newVertex 0, 2, newVertex 9), 
					   (newVertex 1, 4, newVertex 3)]


graph3				:: [Old_Edge]
graph3				= [(newVertex 0, 6, newVertex 1), (newVertex 1, 6, newVertex 0), 
					   (newVertex 0, 5, newVertex 2), (newVertex 2, 5, newVertex 0),
					   (newVertex 1, 9, newVertex 2), (newVertex 2, 9, newVertex 1),
					   (newVertex 1, 13, newVertex 4), (newVertex 4, 13, newVertex 1),
					   (newVertex 2, 16, newVertex 3), (newVertex 3, 16, newVertex 2),
					   (newVertex 2, 12, newVertex 5), (newVertex 5, 12, newVertex 2),
					   (newVertex 4, 15, newVertex 3), (newVertex 3, 15, newVertex 4),
					   (newVertex 4, 8, newVertex 6), (newVertex 6, 8, newVertex 4),
					   (newVertex 3, 7, newVertex 5), (newVertex 5, 7, newVertex 3),
					   (newVertex 5, 3, newVertex 6), (newVertex 6, 3, newVertex 5)]
	

graph4				:: [Old_Edge]
graph4				= [(newVertex 0, 6, newVertex 1), 
					   (newVertex 0, 5, newVertex 2),
					   (newVertex 1, 9, newVertex 2),
					   (newVertex 1, 13, newVertex 4),
					   (newVertex 2, 16, newVertex 3),
					   (newVertex 2, 12, newVertex 5),
					   (newVertex 4, 15, newVertex 3),
					   (newVertex 4, 8, newVertex 6),
					   (newVertex 3, 7, newVertex 5),
					   (newVertex 5, 3, newVertex 6)]				   

