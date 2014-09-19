module Priority_queue ( PQueue, newPQueue, isEmpty, add, addAll, remove, top, printData) where

newtype PQueue a = MyPQueue [a] 
 		   deriving(Eq, Ord, Show, Read)

newPQueue :: PQueue a
newPQueue = MyPQueue []

isEmpty	:: PQueue a -> Bool
isEmpty (MyPQueue [])	= True
isEmpty _		= False

add :: ([a] -> [a]) -> a -> PQueue a -> PQueue a
add f x (MyPQueue xs) = listToPQueue (f (printData (MyPQueue(x:xs))))

addAll :: ([a] -> [a]) -> [a] -> PQueue a -> PQueue a
addAll f [] (MyPQueue xs)	= MyPQueue xs
addAll f (y:ys) (MyPQueue xs)	= addAll f ys (add f y (MyPQueue xs))

remove	:: PQueue a -> (a, PQueue a)
remove queue@(MyPQueue xs)
	| not (isEmpty queue)	= (last xs, MyPQueue (init xs))
	| otherwise 		= error "PQueue is empty"

top :: PQueue a -> a
top (MyPQueue xs) = last xs

printData :: PQueue a -> [a]
printData (MyPQueue [])	= []
printData (MyPQueue xs)	= [x |x <- xs]

listToPQueue :: [a] -> PQueue a
listToPQueue xs	= MyPQueue (reverse xs)
