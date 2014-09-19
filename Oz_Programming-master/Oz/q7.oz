declare
proc {Fold Bintree U}
   case Bintree
   of (U=nil)then skip
   else
      {Fold Bintree.left U}
      {Browse Bintree.value}
      {Fold Bintree.right U}
   end
end
T=tree(value:10 left:
		  tree(value:5 left:tree(value:4 left:nil right:nil)right:tree(value:6 left:nil right:nil))
       right:tree(value:20 left:tree(value:15 left:nil right:nil) right:tree(value:25 left:nil right:nil)))
{Fold T nil}
	