module Main where

import Dfs
import Bfs
import Bft
import Prims
import Kruskals
import Dft

import Graph

main = do menu

menu :: IO ()
menu = do
		header
		putStrLn "\t(1) Depth-First Search"
		putStrLn "\t(2) Depth-First Traversal"
		putStrLn "\t(3) Breadth-First Search"
		putStrLn "\t(4) Breadth-First Traversal"
		putStrLn "\t(5) Prim's Algorithm"
		putStrLn "\t(6) Kruskal's Algorithm"
		putStrLn "\t(0) Exit"
		putStr "\tYour Selection: "
		option <- getOption
		if (isValid option 6)
		    then
				subMenuRouter option
			else
				do
					putStrLn "\tInvalid Selection"
					menu

header :: IO ()
header = do
		putStrLn "\n\tList of Algorithms"
		putStrLn "\t--------------------------"

subMenuRouter :: Int -> IO ()
subMenuRouter x
	| x == 1		= dfsMenu
	| x == 2		= dftMenu
	| x == 3		= bfsMenu
	| x == 4		= bftMenu
	| x == 5		= primsMenu
	| x == 6		= kruskalsMenu
	| otherwise		= putStrLn "\n"

dfsMenu	:: IO ()
dfsMenu	= do
		putStrLn "\n\tMenu -> DF Search"
		putStr "\n\tEnter a Graph: "
		graph <- getGraph
		putStr "\tEnter a Goal Node: "
		goal <- getOption
		let result = (dfs graph goal) :: [Int]
		if (not (isEmpty result))
			then
				putStrLn ("\n\tResult: " ++ (show result))
			else
				do
					putStrLn "\n\tGoal Node is not Found"
		menu

dftMenu	:: IO ()
dftMenu	= do
		putStrLn "\n\tMenu -> DF Traversal"
		putStr "\n\tEnter a Graph: "
		graph <- getGraph
		let result = (dft graph) :: [Int]
		if (not (isEmpty result))
			then
				putStrLn ("\n\tResult: " ++ (show result))
			else
				do
					putStrLn "\n\tNo Traversal Trace Found"
		menu

bfsMenu	:: IO ()
bfsMenu	= do
		putStrLn "\n\tMenu -> BF Search"
		putStr "\n\tEnter a Graph: "
		graph <- getGraph
		putStr "\tEnter a Goal Node: "
		goal <- getOption
		let result = (bfs graph goal) :: [Int]
		if (not (isEmpty result))
			then
				putStrLn ("\n\tResult: " ++ (show result))
			else
				do
					putStrLn "\n\tGoal Node is not Found"
		menu

bftMenu	:: IO ()
bftMenu	= do
		putStrLn "\n\tMenu -> BF Travesal"
		putStr "\n\tEnter a Graph: "
		graph <- getGraph
		let result = (bft graph) :: [Int]
		if (not (isEmpty result))
			then
				putStrLn ("\n\tResult: " ++ (show result))
			else
				do
					putStrLn "\n\tNo Traversal Trace Found"
		menu

primsMenu :: IO ()
primsMenu = do
		putStrLn 	"\n\tMenu -> MST - Prims"
		putStr "\n\tEnter a Graph: "
		graph <- getGraph
		let result = (prims graph) :: [(Int, Int, Int)]
		if (not (isEmpty result))
			then
				putStrLn ("\n\tMinimum Spanning Tree: " ++ (show result))
			else
				do
					putStrLn "\n\tMST is not generated"
		menu
	
kruskalsMenu :: IO ()
kruskalsMenu =  do
		putStrLn 	"\n\tMenu -> MST - Kruskals"
		putStr "\n\tEnter a Graph: "
		graph <- getGraph
		let result = (kruskals graph) :: [(Int, Int, Int)]
		if (not (isEmpty result))
			then
				putStrLn ("\n\tMinimum Spanning Tree: " ++ (show result))
			else
				do
					putStrLn "\n\tMST is not generated"
		menu
		
isValid	:: Int -> Int -> Bool
isValid	a b
	| 0 <= a && a <= b	= True
	| otherwise			= False
	
getOption :: IO Int
getOption = do 
		s <- getLine
		return (read s :: Int)

getGraph :: IO [Old_Edge]
getGraph = do 
		s <- getLine
		let graph = ((buildGraph s) :: [Old_Edge])
		return graph
		if (isEmptyG graph)
			then
				do
					error "Invalid graph entered.."
					return []
			else
				return graph
		
isEmpty	:: [a] -> Bool
isEmpty s
	| (length s) == 0	= True
	| otherwise		= False
	
isEmptyG :: [Old_Edge] -> Bool
isEmptyG s
	| (length s) == 0	= True
	| otherwise		= False
