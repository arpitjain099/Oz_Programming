module Queue ( Queue, newQueue, isEmpty, add, remove, top, printData) where

newtype Queue a = MyQueue [a] 
		  deriving(Eq, Ord, Show, Read)

newQueue :: Queue a
newQueue = MyQueue []

isEmpty	:: Queue a -> Bool
isEmpty (MyQueue [])	= True
isEmpty _		= False

add :: a -> Queue a -> Queue a
add x (MyQueue xs) = MyQueue(x:xs)

remove :: Queue a -> (a, Queue a)
remove queue@(MyQueue xs)
	| not (isEmpty queue)	= (last xs, MyQueue (init xs))
	| otherwise 		= error "Queue is empty"
	
top :: Queue a -> a
top (MyQueue xs) = last xs

printData :: Queue a -> [a]
printData (MyQueue [])	= []
printData (MyQueue xs)	= [x |x <- xs]
