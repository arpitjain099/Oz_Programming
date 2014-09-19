declare
fun {Fold_tree F I}
   fun {FoldR L F I}
      case L
      of nil then I
      []  X|L2 then {F X  {FoldR L2 F I}}
      end
   end
in
   fun {$ L} {FoldR L F I} end
end
T=tree(value:3 left:
		  tree(value:2 left:nil right:nil)
       right:tree(value:4 left:nil right:tree(value:5 left:nil right:nil)))
declare
Prod={Fold_tree fun {$ A B} A*B end nil}
{Browse {Prod T}}
