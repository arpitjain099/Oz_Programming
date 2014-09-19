declare
fun {Filter P Q}
   case P
   of nil then nil
   [] L|R andthen {Q L} then
      L|{Filter R Q}
   [] L|R then {Filter R Q}
   end
end
{
 Browse
 {
  Filter [1 ~1 3 ~7 5 2 ~3 ~5 6] fun {$A} A>=0 end
 }
}
