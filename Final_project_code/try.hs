import Graphics.Ubigraph
import Control.Monad.Trans.Reader
import Control.Concurrent

type Node1	= Vertex1 (Int, Bool)
type Weight1	= Int
type Edge1 	= (Node1, Weight1, Node1)

newtype Vertex1 a = MyVertex1 (a, Bool) 
		    deriving(Eq, Show, Read)

tree1	:: [Edge1]
tree1	= [(newVertex1 1, 10, newVertex1 2), (newVertex1 2, 6, newVertex1 5), (newVertex1 5, 2, newVertex1 6),
		   (newVertex1 5, 2, newVertex1 7), (newVertex1 2, 5, newVertex1 8), (newVertex1 1, 4, newVertex1 3),
		   (newVertex1 3, 1, newVertex1 9), (newVertex1 3, 9, newVertex1 10), (newVertex1 1, 8, newVertex1 4),
		   (newVertex1 4, 4, newVertex1 11), (newVertex1 11, 12, newVertex1 12), (newVertex1 11, 1, newVertex1 13)]

result :: [VertexID]
result = [1, 2, 3, 4, 5, 8, 9, 10, 11, 6, 7, 12, 13]
		 
newVertex1 :: Int -> Vertex1 (Int, Bool)
newVertex1 x = MyVertex1 ((x, False), False)
					   
draw x = do initHubigraph "http://localhost:20738/RPC2" >>= runHubigraph x
main1 = draw $ transform 13 tree1
main2 = draw $ mkRing 10
main3 = draw $ mkRing1 10

main5 = do	id <- getLine
		let x = read id::Int
		--putStrLn (show x)
		draw $ removeEdge x

main4 = transformResult result

transformResult :: [VertexID] -> IO ()
transformResult (x:xs) = do	draw $ setVAttr (VColor "#00dd00") x
				threadDelay 1000000
				draw $ setVAttr (VColor "#ff0099") x
				transformResult xs
transformResult [] = putStrLn "End"


clearAll = draw $ clear

mkRing n = do clear
	      mapM_ (newVertexWithID) all
              mapM_ (newEdge') all
              sid <- newVStyle 0
              mapM_ (flip setVStyleAttr sid) [VColor "#ff0000", VShape Sphere, VSize 1]
              mapM_ (changeVStyle sid) all
    where newEdge' e = newEdge (e, next e)
          next e = (e+1) `mod` n
          all = [0..n-1]
          
mkRing1 n = do 
               sid <- newVStyle 0
               mapM_ (flip setVStyleAttr sid) [VColor "#ffa00f", VShape Cube, VLabel "VERTEX", VSize 1.5]
               mapM_ (changeVStyle sid) all
    where all = [1, 3, 7, 9]
    
transform :: Int -> [Edge1] -> ReaderT Ubigraph IO ()
transform n tr = do clear
		    mapM_ newVertexWithID all
		    mapM_ (newEdge') (mapTransform tr)
		    sid <- newVStyle 0
		    mapM_ (flip setVStyleAttr sid) [VColor "#ff0000", VShape Sphere]
		    mapM_ (changeVStyle sid) all
		    mapM_ makeLabel all
	where all = [1..n]
	      newEdge' e = do id <- newEdge e
			      --setEAttr (EArrowPosition 0.05) id
			      setEAttr (EArrow True) id
			      
			      
	
makeLabel :: VertexID -> Hubigraph Bool
makeLabel x = setVAttr (VLabel (show x)) x
	
mapTransform :: [Edge1] -> [Edge]
mapTransform tr = map extract tr

extract :: Edge1 -> Edge
extract (x, y, z) = (extractFurther x, extractFurther z)

extractFurther :: Vertex1 (a, Bool) -> a
extractFurther (MyVertex1 x) = fst $ fst x
