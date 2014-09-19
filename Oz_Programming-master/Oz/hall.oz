declare
fun {func X}
   if X>=0 then true else false end
end
fun {Filter Q P}
   case Q
   of nil then nil		%%empty list will return empty list back
   [] L|R andthen {P L} then
      L|{Filter R P}			%%carry the check over the rest of the list
   [] L|R then {Filter R Q}		%%recursion step
   end
end
{
 Browse
 {
Filter func [1 ~1 3 ~7 5 2 ~3 ~5 6]%%print the elements which are greater than 0
 }
}