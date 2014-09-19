declare
fun {Foldl A B I}
   case A
   of nil then I
   [] L|R then {
		FoldL R B {
			   B L I
			  }
	       }
   end
end
{
 Browse
 {
  Foldl [1 2 3 4 5]
  fun {$ X Y} X|Y end nil
 }
}
