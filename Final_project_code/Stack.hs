module Stack ( Stack, newStack,	 isEmpty, push, pop, top, printData ) where

newtype Stack a	= MyStack [a] 
		  deriving(Eq, Ord, Show, Read)

newStack :: Stack a
newStack = MyStack []

isEmpty :: Stack a -> Bool
isEmpty (MyStack []) = True
isEmpty _ = False

push :: a -> Stack a -> Stack a
push x (MyStack xs) = MyStack (xs ++ [x])

pop :: Stack a -> Stack a
pop stack@(MyStack xs)	
						
	| not (isEmpty stack)	= MyStack (init xs)
	| otherwise		= error "Stack.pop: Stack is empty"
	
top :: Stack a -> a
top (MyStack []) = error "Stack.top: Stack is empty"
top (MyStack xs) = last xs

printData :: Stack a -> [a]
printData (MyStack []) = []
printData (MyStack xs) = [x |x <- xs]
